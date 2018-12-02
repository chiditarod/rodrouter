class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.integer :race_id, null: false
      t.integer :legs, array: true, null: false, default: []

      t.timestamps
    end

    add_index :routes, :legs, using: 'gin'
    add_index :routes, [:race_id, :legs], unique: true
  end
end
