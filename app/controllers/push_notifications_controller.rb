class PushNotificationsController < ApplicationController

  include PushNotificationsService
  require 'json'

  def create
    send_webpush_notification(current_user.id, params)
    head :ok
  end

  def subscribe
    subscription = Subscription.create_hash(current_user.id, params)
    subscription = Subscription.new(subscription)
    begin subscription.save
      GoogleAnalyticsService.new.event('users', 'subscribe', current_user.uuid)
      response = {"success": "You have successfully subscribed to push notifications"}
    rescue ActiveRecord::RecordNotUnique
      puts "Failed to save subscription"
      response = {"failed": "You have already subscribed to push notifications"}
    end
    render json: response, status: :ok
  end

  def destroy
    subscription_hash = Subscription.create_hash(current_user.id, params)[:subscription_hash]
    begin
      subscription = Subscription.find(subscription_hash)
      subscription.destroy
      GoogleAnalyticsService.new.event('users', 'unsubscribe', current_user.uuid)
      response = {"success": "You have successfully unsubscribed"}
    rescue ActiveRecord::RecordNotFound => ex
      response = {"failed": "You have already unsubscribed"}
    end
    render json: response, status: :ok
  end

  private

  def push_params
    params.permit(:message, { subscription: [:endpoint, :expirationTime, keys: [:auth, :p256dh]]})
  end
end