class TwilioHelper

  def send_text(phone_number, alert_message)
    twilio_number = ENV['TWILIO_NUMBER']
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    phone_number = User.phone_number
    # Trying to call on the users who have plants that need watering.
    alert_message = <<MSG
                    [This is a test] ALERT!
                    One or more of your green babies needs some love.
                    Go to: https://plantia.herokuapp.com/ for more details."
                    MSG

    client.messages.create(
      from: twilio_number,
      to:   phone_number,
      body: alert_message,
    )
  end

end