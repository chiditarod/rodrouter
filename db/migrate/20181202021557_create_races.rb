class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :name
      t.integer :num_checkpoints
      t.integer :max_teams
      t.integer :people_per_team
      t.float :min_total_distance
      t.float :max_total_distance
      t.float :min_leg_distance
      t.float :max_leg_distance
      t.references :start_location, foreign_key: true
      t.references :finish_location, foreign_key: true
      t.integer :distance_unit, default: 0

      t.timestamps
    end
    add_index :races, :name, unique: true
  end
end
