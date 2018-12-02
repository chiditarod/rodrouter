class Leg < ApplicationRecord
  validates :distance, numericality: true
  belongs_to :start, class_name: "Location"
  belongs_to :finish, class_name: "Location"
end
