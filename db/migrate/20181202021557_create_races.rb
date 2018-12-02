class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :name, null: false
      t.integer :num_checkpoints, null: false
      t.integer :max_teams, null: false
      t.integer :people_per_team, null: false
      t.float :min_total_distance, null: false
      t.float :max_total_distance, null: false
      t.float :min_leg_distance, null: false
      t.float :max_leg_distance, null: false
      t.integer :start_id
      t.integer :end_id
      t.integer :distance_unit, default: 0, null: false

      t.timestamps
    end
    add_index :races, :name, unique: true
  end
end
