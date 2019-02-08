class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.integer :max_capacity, null: false
      t.integer :ideal_capacity, null: false
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.float :lat
      t.float :lng

      t.timestamps
    end

    add_index :locations, :name, unique: true
    add_index :locations, [:lat, :lng], unique: true
  end
end
