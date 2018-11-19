class GoogleAnalyticsService
  require 'http'

  def event(category, action, client_id = '555')
    return unless ENV['GA_TRACKING_ID'].present?

    params = {
      :v   => 1,
      :tid => ENV['GA_TRACKING_ID'],
      :cid => client_id,
      :t   => "event",
      :ec  => category,
      :ea  => action,
    }

    begin
      HTTP.timeout(4).get('https://www.google-analytics.com/collect', :params => params).to_s
      return true
    rescue  RestClient::Exception => rex
      return false
    end
  end
end