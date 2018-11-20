class AnalyticsWorker
  include Sidekiq::Worker

  def perform(params)
    puts "Performing analytics event: " + params['ea']
    HTTP.timeout(4).get('https://www.google-analytics.com/collect', :params => params).to_s
  end
end
