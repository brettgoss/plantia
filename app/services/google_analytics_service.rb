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
      AnalyticsWorker.perform_async(params)
      return true
    rescue  HTTP::Error => ex
      return false
    end
  end
end