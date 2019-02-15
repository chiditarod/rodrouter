class Leg < ApplicationRecord
  validates :distance, numericality: true  # in meters
  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"

  has_many :legs_routes
  has_many :routes, through: :legs_routes

  validates_associated :routes

  before_validation :fetch_distance, unless: Proc.new { distance.present? }
  after_save :create_mirror_leg

  attr_accessor :test_mode

  # TODO: This belongs in a decorator
  def to_s(unit=nil)
    dist = distance.present? ? case unit
           when nil
             "#{distance} m"
           when 'mi'
             "#{Distances.km_to_mi(distance/1000).round(2)} mi"
           when 'km'
             "#{(distance/1000).round(2)} km"
           end : '?'

    "#{start || '?' } --(#{dist})--> #{finish || '?'}"
  end

  # find Legs where the start and finish location are
  # both contained in the parent race's location pool
  # TODO: Rename to in_race
  scope :valid_for_race, ->(race) do
    ids = Race.find(race.id).locations.map(&:id)
    where("start_id IN (?) AND finish_id IN (?)", ids, ids)
  end

  def fetch_distance
    self.distance = if @test_mode.is_a?(Hash)
      # TODO: optimize
      d = Random.rand(test_mode[:max])
      while d < test_mode[:min]
        d = Random.rand(test_mode[:max])
      end
      d
    else
      #raise StandardError.new('Not Yet Supported!')
      client = GoogleApiClient.new.client
      resp = client.distance_matrix(
        [start.full_address],
        [finish.full_address],
        mode: 'walking',
        language: 'en-US',
        avoid: 'tolls',
        units: 'imperial')

      resp.dig(:rows).first.dig(:elements).first.dig(:distance, :value)
    end
  end

  # the current model is to "duplicate" a leg twice, using
  # each location as a starting point and finish point.
  # A future optimization can be to de-dupe these records, using a single
  # record to represent the leg between both locations
  def create_mirror_leg
    return if Leg.where(start: finish, finish: start).present?
    Leg.create start: finish, finish: start, distance: distance
  end

  # create all possible legs based on a pool of locations
  def self.create_from_locations(locations, test_mode=false)
    locations.each do |loc_a|
      locations.reject { |l| l == loc_a }.each do |loc_b|
        next if Leg.where(start: loc_a, finish: loc_b).present?
        Leg.create(start: loc_a, finish: loc_b, test_mode: test_mode)
      end
    end
  end
end
