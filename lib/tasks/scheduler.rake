desc "This task is called by the Heroku scheduler add-on"
task :update_water_event => :environment do
  puts "Updating water_events..."
  NewsFeed.update
  puts "done."
end

task :send_text => :environment do
  User.send_text
end

# call on water events function to water plant
# task = alert when a plant needs watering.
# enviroment do water_events.update
# task call on Twillio's send_text function to users phones who need to water their plants.
# User.phone_number twillio app_send text.