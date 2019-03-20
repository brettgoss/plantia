# frozen_string_literal: true

class GoogleAnalyticsService
  require 'http'

  def event(category, action, client_id = '555')
    return false unless ENV['GA_TRACKING_ID'].present?

    @params = get_params(category, action, client_id)

    send_analytics_event
  end

  private

  def send_analytics_event
    AnalyticsWorker.perform_async(@params)
    true
  rescue HTTP::Error
    Rails.logger.error('Failed to connect to Google Analytics')
    false
  rescue Redis::CannotConnectError
    Rails.logger.error('Failed to connect to Redis')
    false
  end

  def get_params(category, action, client_id)
    {
      v: 1,
      tid: ENV['GA_TRACKING_ID'],
      cid: client_id,
      t: 'event',
      ec: category,
      ea: action
    }
  end
end
