class CreateLegs < ActiveRecord::Migration[5.2]
  def change
    create_table :legs do |t|
      t.integer :start_id, null: false
      t.integer :end_id, null: false
      t.float :distance, null:false

      t.timestamps
    end
  end
end
