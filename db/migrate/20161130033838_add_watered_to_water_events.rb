class AddWateredToWaterEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :water_events, :watered, :boolean, :default => false
  end
end
