class Race < ApplicationRecord
  validates :num_checkpoints, :max_teams, :people_per_team,
    numericality: { only_integer: true }
  validates :min_total_distance, :max_total_distance, :min_leg_distance, :max_leg_distance,
    numericality: true

  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"
  has_many :available_locations, class_name: "Location"

  enum distance_unit: { mi: 0, km: 1 }
end
