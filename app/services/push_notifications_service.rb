# frozen_string_literal: true

# Handles sending of webpush notifications
class PushNotificationsService < BaseService
  require 'json'

  def initialize(user_id, message_params)
    @user_id = user_id
    @message_params = message_params
  end

  def call
    send_webpush_notification(@user_id, @message_params)
  end

  private

  def send_webpush_notification(user_id, params)
    return false if params[:message].blank?
    return false if ENV['VAPID_PUBLIC_KEY'].blank? || ENV['VAPID_PRIVATE_KEY'].blank?

    Rails.logger.info "Sending push notification from #{params.inspect}"
    @endpoint = params[:subscription][:endpoint]
    @auth     = params[:subscription][:keys][:auth]
    @key      = params[:subscription][:keys][:p256dh]
    @message  = JSON.generate(
      title: params[:message][:title],
      body: params[:message][:body]
    )

    begin
      Webpush.payload_send(
        message: @message,
        endpoint: @endpoint,
        p256dh: @key,
        auth: @auth,
        vapid: {
          subject: 'mailto:plantiapp@gmail.com',
          public_key: ENV['VAPID_PUBLIC_KEY'],
          private_key: ENV['VAPID_PRIVATE_KEY']
        },
        ssl_timeout: 5, # value for Net::HTTP#ssl_timeout=, optional
        open_timeout: 5, # value for Net::HTTP#open_timeout=, optional
        read_timeout: 5 # value for Net::HTTP#read_timeout=, optional
      )
      return true
    rescue Webpush::InvalidSubscription => ex
      Rails.logger.info 'Subscription not valid. Deleting...'
      begin
        subscription_hash = Subscription.create_hash(user_id, params)[:subscription_hash]
        subscription = Subscription.find(subscription_hash)
        subscription.destroy
      rescue ActiveRecord::RecordNotFound
        Rails.logger.info 'Error while deleting: subscription not found.'
      end
      return false
    end
  end
end
