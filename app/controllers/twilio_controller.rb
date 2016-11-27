class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

rescue_from StandardError do |exception|
  trigger_sms_alerts(exception)
end

# Figure out how to add plant.nickname into msg
def trigger_sms_alerts (exception)
     alert_message = <<MSG
  [This is a test] ALERT!
  Time to water your plant!
  Exception: #{exception}.
  Go to: https://plantia.herokuapp.com/ for more details."
  MSG
end

def send_text(phone_number, alert_message)
    twilio_number = ENV['TWILIO_NUMBER']
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    client.messages.create(
      from: twilio_number,
      to:   phone_number,
      body: alert_message,
    )
  end
