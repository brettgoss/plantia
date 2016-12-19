class TwilioHelper
  require 'twilio-ruby'

  def send_text(user)
    if user.phone_number
      phone_number = user.phone_number
      twilio_number = ENV["TWILIO_NUMBER"]
      @client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
      alert_message = "Your plants need watering! Go to: http://plantia.io for more details."
      puts "sending text to #{user.phone_number}"
      @client.account.messages.create(
        :from => twilio_number,
        :to => phone_number,
        :body => alert_message
      )
      puts "text sent"
    end
  end
end
