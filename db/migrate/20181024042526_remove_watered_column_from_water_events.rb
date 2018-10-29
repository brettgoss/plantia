class RemoveWateredColumnFromWaterEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :water_events, :watered
  end
end
