# frozen_string_literal: true

# Handles webpush subscriptions
class PushNotificationsController < ApplicationController
  require 'json'

  def create
    if PushNotificationsService.call(current_user.id, params)
      head :ok
    else
      head 404
    end
  end

  def subscribe
    subscription = Subscription.create_hash(current_user.id, params)
    subscription = Subscription.new(subscription)
    begin
      subscription.save
      GoogleAnalyticsService.call(
        GoogleAnalyticsService::Categories::USERS,
        GoogleAnalyticsService::Actions::SUBSCRIBE,
        current_user.uuid
      )

      response = { "success": 'You have successfully subscribed to push notifications' }
    rescue ActiveRecord::RecordNotUnique
      Rails.logger.info 'Failed to save subscription'
      response = { "failed": 'You have already subscribed to push notifications' }
    end
    render json: response, status: :ok
  end

  def destroy
    subscription_hash = Subscription.create_hash(current_user.id, params)[:subscription_hash]
    begin
      subscription = Subscription.find(subscription_hash)
      subscription.destroy
      GoogleAnalyticsService.call(
        GoogleAnalyticsService::Categories::USERS,
        GoogleAnalyticsService::Actions::UNSUBSCRIBE,
        current_user.uuid
      )

      response = { "success": 'You have successfully unsubscribed' }
    rescue ActiveRecord::RecordNotFound
      response = { "failed": 'You have already unsubscribed' }
    end
    render json: response, status: :ok
  end

  private

  def push_params
    params.permit(:message, subscription: [:endpoint, :expirationTime, keys: %i[auth p256dh]])
  end
end
