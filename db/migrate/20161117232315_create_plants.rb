class CreatePlants < ActiveRecord::Migration[5.0]
  def change
    create_table :plants do |t|
      t.string :nickname
      t.string :common_name
      t.string :light
      t.integer :water_freq
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
