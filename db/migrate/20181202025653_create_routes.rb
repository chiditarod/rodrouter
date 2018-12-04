class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.integer :race_id, null: false
      t.integer :leg_ids, array: true, default: []

      t.timestamps
    end

    add_index :routes, :leg_ids, using: 'gin'
    add_index :routes, [:race_id, :leg_ids], unique: true
  end
end
