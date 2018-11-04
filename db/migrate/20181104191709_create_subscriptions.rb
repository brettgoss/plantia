class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def self.up
    create_table :subscriptions, id: false do |t|
      t.string :subscription_hash, primary_key: true
      t.json :subscription
      t.references :user, foreign_key: true
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
