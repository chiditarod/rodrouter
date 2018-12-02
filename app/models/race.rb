class Race < ApplicationRecord
  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"
  #has_many :available_locations, class_name: "Location"

  enum distance_unit: { mi: 0, km: 1 }
end
