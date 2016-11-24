class CreatePlantlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :plantlogs do |t|
      t.date :logtime
      t.string :title
      t.text :logtext
      t.references :plant, foreign_key: true

      t.timestamps
    end
  end
end
