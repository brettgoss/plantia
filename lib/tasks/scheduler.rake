require 'twilio_helper'

desc "This task is called by the Heroku scheduler add-on"
task :send_text => :environment do

  twilio = TwilioHelper.new
  User.has_thristyplant.each do |user| twilio.send_text(user) end
end
