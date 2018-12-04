class CreateLocationsRacesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :locations, :races

    add_index :locations_races, :location_id
    add_index :locations_races, :race_id
  end
end
