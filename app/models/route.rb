class Route < ApplicationRecord
  #has_many :available_locations, through: :race
  belongs_to :race

  validates :legs_array, presence: true

  def legs
    legs_array.map do |location_id|
      Location.find(location_id)
    end
  end
end
