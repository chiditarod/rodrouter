class Race < ApplicationRecord
  validates :num_stops, :max_teams, :people_per_team,
    numericality: { only_integer: true }
  validates :min_total_distance, :max_total_distance, :min_leg_distance, :max_leg_distance,
    numericality: true

  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"
  has_many :routes

  enum distance_unit: { mi: 0, km: 1 }

  def location_pool
    Location.where("id IN (?)", location_id_pool)
    # TODO: benchmark how much slower this is
    # location_id_pool.map { |id| Location.find(id) }
  end
end
