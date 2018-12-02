class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :max_capacity
      t.integer :ideal_capacity
      t.string :street_address
      t.string :city
      t.string :state
      t.decimal10 :lat
      t.decimal2 :lat
      t.decimal10 :lon
      t.decimal2 :lon
      t.boolean :enabled

      t.timestamps
    end
    add_index :locations, :name, unique: true
  end
end
