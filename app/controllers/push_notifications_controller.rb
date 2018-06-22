class PushNotificationsController < ApplicationController
  def create
    Rails.logger.info "Sending push notification from #{push_params.inspect}"

    Webpush.payload_send(
      message: params[:message],
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
    head :ok
  end

  private

  def push_params
    params.permit(:message, { subscription: [:endpoint, keys: [:auth, :p256dh]]})
  end
end