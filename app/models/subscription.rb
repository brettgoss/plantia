class Subscription < ApplicationRecord
  belongs_to :user
  validates :subscription, presence: true
  validates :user_id, presence: true

  def self.create_hash(user_id, params)
    subscription = {
      :user_id => user_id.to_i,
      :subscription => {
        endpoint: params[:subscription][:endpoint],
        p256dh: params[:subscription][:keys][:p256dh],
        auth: params[:subscription][:keys][:auth]
      }
    }
    subscription.merge!(subscription_hash: Digest::SHA2.new(512).hexdigest(subscription.to_json))
  end

  def self.fetch_dry_plant_subscriptions
    sql = <<-SQL
      SELECT s.user_id, MAX(p.nickname) AS plant_name, s.subscription
      FROM water_events e
        INNER JOIN plants p ON e.plant_id = p.id
        INNER JOIN users u ON p.user_id = u.id
        INNER JOIN subscriptions s ON s.user_id = u.id
      WHERE e.water_date BETWEEN (CURRENT_DATE - INTERVAL '7 days') AND (CURRENT_DATE - INTERVAL '1 day')
      GROUP BY s.subscription_hash
    SQL

    records_array = ActiveRecord::Base.connection.exec_query(sql)
    records_array.to_hash
  end
end