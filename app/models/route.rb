class Route < ApplicationRecord
  belongs_to :race
  validates :race, presence: true

  has_many :legs_routes, -> { order('legs_routes.order') } #, dependent: :destroy
  has_many :legs, through: :legs_routes

  validate :validate_leg_distances,
           :validate_leg_locations_allowed_in_race,
           :validate_finish_is_at_end

  # TODO:
  # Add a DB boolean and index when the route is complete, and add a hook to check/modify it

  # once a certain # of legs are added, set a boolean attribute
  # on the record that enables additional validations from here on out
  before_validation :check_leg_threshold
  with_options if: :leg_threshold_crossed do |r|
    r.validate :validate_leg_count
    r.validate :validate_route_length
  end

  validate :validate_finish_is_at_end, if: :has_all_legs?
  validate :validate_finish_not_used_until_end, unless: :has_all_legs?

  def complete?
    valid? && has_all_legs?
  end

  def has_all_legs?
    legs.size == target_leg_count
  end

  def target_leg_count
    race.num_stops + 1
  end

  def legs_needed
    target_leg_count - legs.size
  end

  def distance
    legs.inject(0.0) { |memo, l| memo += l.distance }.round(2)
  end

  def validate_route_uniqueness
  end

  def validate_leg_count
    unless legs.size == target_leg_count
      errors.add(:legs, "This race requires a route to have exactly #{race.num_stops + 1} legs (currently #{legs.size} legs)")
    end
  end

  def validate_finish_not_used_until_end
    return unless legs.size < target_leg_count

    if legs.map(&:finish).include?(race.finish)
      errors.add(:legs, "The race finish location: #{race.finish} cannot be used until the end")
    end
  end

  def validate_finish_is_at_end
    return unless legs.size == target_leg_count

    unless legs.last.finish == race.finish
      errors.add(:legs, "The last leg needs to finish at: #{race.finish}. Currently: #{legs.last.finish}")
    end
  end

  def validate_route_length
    total_distance = legs.map(&:distance).reduce(&:+) || 0
    if total_distance < race.min_total_distance
      errors.add(:legs, "Route length is too short (#{total_distance} < #{race.min_total_distance})")
    end
    if total_distance > race.max_total_distance
      errors.add(:legs, "Route length is too long (#{total_distance} > #{race.max_total_distance})")
    end
  end

  # TODO: change this to add an error entry per incorrect leg
  def validate_leg_distances
    distances = legs.map(&:distance)
    if distances.any? { |l| l < race.min_leg_distance }
      errors.add(:legs, "cannot use a leg with distance < #{race.min_leg_distance}")
    end

    if distances.any? { |l| l > race.max_leg_distance }
      errors.add(:legs, "cannot use a leg with distance > #{race.max_leg_distance}")
    end
  end

  # TODO: include the leg id and location names in the error
  def validate_leg_locations_allowed_in_race
    route_locations =
      legs.map(&:finish).map(&:id).
      concat(legs.map(&:start).map(&:id)).uniq

    invalid_locations = route_locations - (route_locations & race.locations.map(&:id))
    invalid_locations.each do |location_id|
      errors.add(:legs, "Location #{location_id} is used in a leg but is not allowed in this race")
    end
  end

  def to_s
    return "EMPTY" if legs.size.zero?
    legs_arr = legs.to_a

    start_leg = legs_arr.slice!(0)
    prefix = "[#{legs.size}/#{target_leg_count} legs, #{distance} #{race.distance_unit}]"
    legs_arr.inject("#{prefix} #{start_leg}") do |memo, leg|
      memo + " --(#{leg.distance.round(2)})--> #{leg.finish}"
    end
  end

  private

  def check_leg_threshold
    self.leg_threshold_crossed ||= (legs.size >= target_leg_count)
  end
end
