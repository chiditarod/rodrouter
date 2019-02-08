class Race < ApplicationRecord
  validates :num_stops, :max_teams, :people_per_team,
    numericality: { only_integer: true }
  validates :min_total_distance, :max_total_distance, :min_leg_distance, :max_leg_distance,
    numericality: true

  #validates_uniqueness_of :locations

  # TODO: validate that start and end are in the location pool

  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"
  has_and_belongs_to_many :locations
  has_many :routes

  enum distance_unit: { mi: 0, km: 1 }
end
