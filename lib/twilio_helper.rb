class TwilioHelper
  require 'twilio-ruby'

  def send_text(user)
    # twilio_number = ENV['TWILIO_NUMBER']
     phone_number = user.phone_number
     twilio_sid = "AC7011efdc779e50376cf818a70aff0736"
     twilio_token = "760e6cf8a2c4892843b530c19ad398fe"
     twilio_number = "+17784001638"
    @client = Twilio::REST::Client.new twilio_sid, twilio_token
     puts phone_number
    # Trying to call on the users who have plants that need watering.
    alert_message = "One or more of your green babies needs some love. Go to: https://plantia.herokuapp.com/ for more details."
    puts "sending_text"
    @client.account.sms.messages.create(
      :from => twilio_number,
      :to =>  phone_number,
      :body => alert_message,
    )
    puts "text sent"
  end
end

 # def send_text_message
 #    number_to_send_to = params[:number_to_send_to]

 #    twilio_sid = "abc123"
 #    twilio_token = "foobar"
 #    twilio_phone_number = "6165555555"

 #    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

 #    @twilio_client.account.sms.messages.create(
 #      :from => "+1#{twilio_phone_number}",
 #      :to => number_to_send_to,
 #      :body => "This is an message. It gets sent to #{number_to_send_to}"
 #    )

#  TWILIO_NUMBER=+17784001638
# TWILIO_ACCOUNT_SID=AC7011efdc779e50376cf818a70aff0736
# TWILIO_AUTH_TOKEN=760e6cf8a2c4892843b530c19ad398fe