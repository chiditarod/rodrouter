class Location < ApplicationRecord
  validates :max_capacity, :ideal_capacity,
    numericality: { only_integer: true }

  #has_many :races_where_starting_line, class_name: "Race", foreign_key: "start_id"
  #has_many :races_where_finish_line, class_name: "Race", foreign_key: "finish_id"

  has_and_belongs_to_many :races

  #scope :used_as_starting_line, -> { joins(:races).where(races: { start_id: id }) }
  #scope :used_as_finish_line, -> { joins(:races).where(races: { finish_id: id }) }

  #scope :for_race, ->(race_id) { wh}

  def to_s
    name
  end
end
