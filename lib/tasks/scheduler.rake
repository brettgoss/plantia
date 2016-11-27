desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end

# call on water events function to water plant
# might need a notifications controller to integrate twilio's API
# task = Water plant or plant needs water.
# enviroment do water_events.update
# task will Twilio API text function to user phone number.
#User.phone_number twillio app send reminder.
#function in control? notifications controller? require twillio gem.