class CreateLegsRoutesJoinTable < ActiveRecord::Migration[5.2]
  def change

    create_join_table :legs, :routes do |t|
      t.index :leg_id
      t.index :route_id
    end

    add_column :legs_routes, :order, :integer, null: false
    add_index :legs_routes, [:leg_id, :route_id, :order], unique: true
  end
end
