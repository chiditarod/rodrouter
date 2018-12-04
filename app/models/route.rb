class Route < ApplicationRecord
  has_many :available_locations, through: :race
  belongs_to :race

  validates :race, :leg_ids, presence: true
  validates_with RouteValidator

  def too_short?
    # is length of all legs in order < race.min_length
    # AND # of locations < num_stops
  end

  def too_long?
    # is length of all legs in order > race.max_length
  end

  def legs_too_long?
    # are any legs longer than the max leg length
  end

  def legs_too_short?
    # are any legs shorter than the max leg length
  end

  def legs
    Leg.where("id IN (?)", leg_ids)
  end
end
