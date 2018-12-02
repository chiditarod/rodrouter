class Race < ApplicationRecord
  has_one :start, class_name: "Location"
  has_one :end, class_name: "Location"
  has_many :available_locations, class_name: "Location"

  enum distance_unit: { mi: 0, km: 1 }
end
