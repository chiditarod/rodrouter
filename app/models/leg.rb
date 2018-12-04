class Leg < ApplicationRecord
  validates :distance, numericality: true
  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"

  has_many :legs_routes
  has_many :routes, through: :legs_routes

  validates_associated :routes

  # TODO: there may be a better hook here that still works with FactoryBot
  before_validation :fetch_distance, unless: Proc.new { distance.present? }
  after_save :create_mirror_leg

  attr_accessor :test_mode

  def to_s
    "#{start || '?' } --(#{distance.round(2) || '?'})--> #{finish || '?'}"
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
      # TODO: build integration with google maps api to calculate distance
      raise StandardError.new('Not Yet Supported!')
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
