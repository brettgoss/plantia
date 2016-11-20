class CreateWaterEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :water_events do |t|
      t.datetime :date
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
