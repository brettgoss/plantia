# frozen_string_literal: true

# Handles sending of webpush notifications
class PushNotificationsService < BaseService
  require 'json'

  def initialize(user_id, message_params)
    @user_id = user_id
    @message_params = message_params
  end

  def call
    return false if @message_params[:message].blank?
    return false if ENV['VAPID_PUBLIC_KEY'].blank? || ENV['VAPID_PRIVATE_KEY'].blank?

    Rails.logger.info "Sending push notification from #{@message_params.inspect}"
    send_webpush_notification
  end

  private

  def send_webpush_notification
    Webpush.payload_send(build_payload)
    true
  rescue Webpush::InvalidSubscription
    Rails.logger.info 'Subscription not valid. Deleting...'
    begin
      delete_invalid_subscription
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info 'Error while deleting: subscription not found.'
    end
    false
  end

  def delete_invalid_subscription
    subscription = Subscription.create_hash(@user_id, @message_params)
    Subscription.find(subscription[:subscription_hash]).destroy
  end

  def build_payload
    {
      message: build_message,
      vapid: build_vapid,
      endpoint: @message_params[:subscription][:endpoint],
      p256dh: @message_params[:subscription][:keys][:p256dh],
      auth: @message_params[:subscription][:keys][:auth],
      ssl_timeout: 5, open_timeout: 5, read_timeout: 5
    }
  end

  def build_message
    JSON.generate(
      title: @message_params[:message][:title],
      body: @message_params[:message][:body]
    )
  end

  def build_vapid
    {
      subject: 'mailto:plantiapp@gmail.com',
      public_key: ENV['VAPID_PUBLIC_KEY'],
      private_key: ENV['VAPID_PRIVATE_KEY']
    }
  end
end
