require 'twilio_helper'

desc "This task is called by the Heroku scheduler add-on"
task :update_water_event => :environment do

 twilio = TwilioHelper.new
User.has_thristyplant. each do |user| user.send_text #text them

end
#   Plant.needs_water.each do |plant|
#     # ...
#   end


#   puts "Checking days till water is ..."
#   if (WaterEvents.days_till_water <= -1) do
#   task :send_text => :environment do
#   User.send_text
#   puts "Sending texts"
# else
#   puts "No plants need watering, no notifications needed"
# end


# task = alert when a plant needs watering.
# enviroment do water_events.update
# task call on Twillio's send_text function to users phones who need to water their plants.
# User.phone_number twillio app_send text.