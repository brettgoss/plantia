module PushNotifications
  # TODO: Refactor this into a service
  require 'json'
  def send_webpush_notification(params)
    Rails.logger.info "Sending push notification from #{params.inspect}"
    begin
      @endpoint = params[:subscription][:endpoint]
      title = params[:message][:title].nil? ? params[:message] : params[:message][:title]
      body = params[:message][:body].nil? ? params[:message] : params[:message][:body]
      puts "Title " + title
      message = {
          title: title,
          body: body,
      }
      Webpush.payload_send(
        message: JSON.generate(message),
        endpoint: params[:subscription][:endpoint],
        p256dh: params[:subscription][:keys][:p256dh],
        auth: params[:subscription][:keys][:auth],
        vapid: {
          subject: "mailto:plantiapp@gmail.com",
          public_key: ENV['VAPID_PUBLIC_KEY'],
          private_key: ENV['VAPID_PRIVATE_KEY']
        },
        ssl_timeout: 5, # value for Net::HTTP#ssl_timeout=, optional
        open_timeout: 5, # value for Net::HTTP#open_timeout=, optional
        read_timeout: 5 # value for Net::HTTP#read_timeout=, optional
      )
    rescue Webpush::InvalidSubscription => ex
      puts @endpoint
      puts "Rescued"
      puts ex
    end
  end
end
