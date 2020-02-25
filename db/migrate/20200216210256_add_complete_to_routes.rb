class AddCompleteToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :complete, :boolean, null: false, default: false
  end
end
