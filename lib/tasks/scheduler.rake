# require 'twilio_helper'
require 'seed_helper'
require 'json'

# desc "This task is called by the Heroku scheduler add-on"
# task :send_text => :environment do
#   twilio = TwilioHelper.new
#   User.has_thristy_plant.each do |user|
#     twilio.send_text(user)
#   end
# end

desc "This will be called only once on Heroku manually"
task :seed => :environment do
  seedhelper = SeedHelper.new
  seedhelper.seed_data
end

desc "This checks for plants that need watering and triggers the webpush notifications"
task :notify => :environment do
  def get_users_with_recently_watered_plants(num_days = 2)
    @users_with_thirsty_plants = {}
    users = User.all
    users.each do |user|
      water_events = user.water_events.where("water_date > ?", num_days.days.ago.beginning_of_day).to_a
      if water_events.any?
        @users_with_thirsty_plants["user_#{user.id}"] = water_events
      end
    end
  end

  def get_users_with_thirsty_plants
    @thirsty_plants = {}
    @users_with_thirsty_plants.map do |user, events|
      plants = {}
      events.each do |event|
        if (!plants.include? event.plant_id) && event.water_date <= DateTime.now
          plants["plant_#{event.plant_id}"] = event.water_date
        elsif event.water_date > DateTime.now
          plants.delete("plant_#{event.plant_id}")
        end
      end
      @thirsty_plants["#{user}"] = plants
    end
  end

  def notify_user(user, plant_info)
    puts user
    include PushNotifications
    params = {
      :message => 'You clicked a button!',
      :subscription => user[:subscription]
    }
    send_webpush_notification(params)
  end

  get_users_with_recently_watered_plants(2)
  get_users_with_thirsty_plants()

  @thirsty_plants.map do |user, plant|
    user_hash = {
      :subscription => {
        :endpoint => ENV['SUBSCRIPTION_ENDPOINT'],
        :keys => {
          :p256dh => ENV['SUBSCRIPTION_KEY'],
          :auth => ENV['SUBSCRIPTION_AUTH']
        },
      }
    }
    notify_user(user_hash, plant)
  end
  puts "\nThirsty plants: "
  puts @thirsty_plants.to_json
end
