class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.integer :race_id, null: false
      t.integer :legs_array, array: true, default: []

      t.timestamps
    end

    add_index :routes, :legs_array, using: 'gin'
    add_index :routes, [:race_id, :legs_array], unique: true
  end
end
