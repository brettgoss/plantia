class ChangeColumnNameWaterEventsDateToWaterDate < ActiveRecord::Migration[5.0]
  def change
    rename_column :water_events, :date, :water_date
  end
end
