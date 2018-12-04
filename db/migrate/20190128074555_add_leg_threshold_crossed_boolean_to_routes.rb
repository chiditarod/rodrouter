class AddLegThresholdCrossedBooleanToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :leg_threshold_crossed, :boolean, null: false, default: false
  end
end
