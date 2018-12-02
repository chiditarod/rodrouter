class Race < ApplicationRecord
  enum distance_unit: { mi: 0, km: 1 }
  belongs_to :start_location
  belongs_to :finish_location
end
