class PushNotificationsController < ApplicationController
  include PushNotifications
  def create
    send_webpush_notification(params)
    head :ok
  end

  private

  def push_params
    params.permit(:message, { subscription: [:endpoint, :expirationTime, keys: [:auth, :p256dh]]})
  end
end