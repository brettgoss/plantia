class UpdatePastWaterEvents < ActiveRecord::Migration[5.0]
  def change
    say_with_time "Updating water events..." do
      WaterEvent.update_all(watered: true)
    end
  end
end
