class Location < ApplicationRecord
  #has_many :legs
  has_many :starting_line_for, class_name: "Race", foreign_key: "start_id"
  has_many :finish_line_for, class_name: "Race", foreign_key: "finish_id"
end
