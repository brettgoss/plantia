class GoogleAnalyticsService

  def event(category, action, client_id = '555')
    return unless ENV['GA_TRACKING_ID'].present?

    params = {
      v: 1,
      tid: ENV['GA_TRACKING_ID'],
      cid: client_id,
      t: "event",
      ec: category,
      ea: action,
    }

    begin
      RestClient.get('http://www.google-analytics.com/collect', params: params, timeout: 4, open_timeout: 4)
      return true
    rescue  RestClient::Exception => rex
      return false
    end
  end
end