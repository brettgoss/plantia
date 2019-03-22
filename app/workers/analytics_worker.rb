# frozen_string_literal: true

class AnalyticsWorker
  include Sidekiq::Worker

  def perform(params)
    Rails.logger.info('Performing analytics event: ' + params['ea'])
    # TODO: Don't use timeout
    HTTP.timeout(4).get('https://www.google-analytics.com/collect', params: params).to_s
  end
end
