class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

def send_text(phone_number, alert_message)
    twilio_number = ENV['TWILIO_NUMBER']
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    phone_number = User.phone_number
    # Trying to call on the specific plant belongs to the user that needs to be watered.
    plant = Plant.id.where(Plant.user_id == User_id)
    # Trying to include plant nickname and commonname in sms.
    #Maybe try a blanket text first ex: Hey one of your plants needs watering please check Plantia.
    alert_message = <<MSG
                    [This is a test] ALERT!
                    Time to water your plant!
                    #{plant_nickname} #{plant_common_name}
                    Go to: https://plantia.herokuapp.com/ for more details."
                    MSG

    client.messages.create(
      from: twilio_number,
      to:   phone_number,
      body: alert_message,
    )
  end

# @message = @client.messages.create(
#       from: twilio_number,
#       to:   phone_number,
#       body: alert_message,
#       )
# end