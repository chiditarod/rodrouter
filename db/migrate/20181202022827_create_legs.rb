class CreateLegs < ActiveRecord::Migration[5.2]
  def change
    create_table :legs do |t|
      t.float :distance, null:false
      t.integer :start_id, null: false
      t.integer :finish_id, null: false

      t.timestamps
    end
  end
end
