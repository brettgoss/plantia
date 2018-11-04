class PushNotificationsController < ApplicationController
  before_action :authenticate_user!

  include PushNotifications
  require 'json'

  def create
    send_webpush_notification(params)
    head :ok
  end

  def subscribe
    subscription = {
      :user_id => current_user.id,
      :subscription => {
        endpoint: params[:subscription][:endpoint],
        p256dh: params[:subscription][:keys][:p256dh],
        auth: params[:subscription][:keys][:auth]
      }
    }
    subscription.merge!(subscription_hash: Digest::SHA2.new(512).hexdigest(subscription.to_json))
    subscription = Subscription.new(subscription)
    begin subscription.save
      response = {"success": "You have successfully subscribed to push notifications"}
    rescue ActiveRecord::RecordNotUnique
      puts "Failed to save subscription"
      response = {"failed": "You have already subscribed to push notifications"}
    end
    render json: response, status: :ok
  end

  def destroy
    puts "unsubscribed"
  end

  private

  def push_params
    params.permit(:message, { subscription: [:endpoint, :expirationTime, keys: [:auth, :p256dh]]})
  end
end