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
end