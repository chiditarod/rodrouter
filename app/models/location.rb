class Location < ApplicationRecord
  validates :max_capacity, numericality: { only_integer: true }
  validates :ideal_capacity, numericality: { only_integer: true }
  has_many :races_where_starting_line, class_name: "Race", foreign_key: "start_id"
  has_many :races_where_finish_line, class_name: "Race", foreign_key: "finish_id"
end
