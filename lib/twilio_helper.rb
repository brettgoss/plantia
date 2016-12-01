class TwilioHelper
  require 'twilio-ruby'

  def send_text(user)
     phone_number = user.phone_number
     twilio_number = ENV["TWILIO_NUMBER"]
    @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
     puts phone_number
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