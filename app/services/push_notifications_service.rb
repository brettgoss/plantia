module PushNotificationsService
  require 'json'

  def notify_user_of_thirsty_plant(details, subscription_hash)
    user_id    = details['user_id']
    plant_name = details['plant_name']
    message_params = {
      :message => {
        :title => "Your plants are thirsty!",
        :body => "Your plant #{plant_name} needs watering!",
      },
      :subscription => subscription_hash
    }
    send_webpush_notification(user_id, message_params)
  end

  def send_webpush_notification(user_id, params)
    Rails.logger.info "Sending push notification from #{params.inspect}"
    @endpoint = params[:subscription][:endpoint]
    @auth     = params[:subscription][:keys][:auth]
    @key      = params[:subscription][:keys][:p256dh]
    @message  = JSON.generate({
        title:  params[:message][:title],
        body:   params[:message][:body],
    })

    begin
      Webpush.payload_send(
        message: @message,
        endpoint: @endpoint,
        p256dh: @key,
        auth: @auth,
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
      puts "Subscription not valid. Deleting..."
      subscription_hash = Subscription.create_hash(user_id, params)[:subscription_hash]
      subscription = Subscription.find(subscription_hash)
      subscription.destroy
    end
  end
end
