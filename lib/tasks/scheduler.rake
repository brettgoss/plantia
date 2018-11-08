# require 'twilio_helper'
require 'seed_helper'
require 'json'

desc "This will be called only once on Heroku manually"
task :seed => :environment do
  seedhelper = SeedHelper.new
  seedhelper.seed_data
end

namespace :notifications do
  desc "This checks for plants that need watering and outputs to console"
  task :check_thirsty_plants, [:days_since_watered] => :environment do |task, args|
    days_since_watered = args[:days_since_watered].to_i
    @thirsty_plants = User.get_thirsty_plants_by_user(days_since_watered)

    puts "\nThirsty plants: "
    puts @thirsty_plants.to_json
  end

  desc "This checks for plants that need watering and triggers the webpush notifications"
  task :send_watering_notification, [:days_since_watered] => :environment do |task, args|
    days_since_watered = args[:days_since_watered].to_i
    @thirsty_plants = User.get_thirsty_plants_by_user(days_since_watered)

    def notify_user(user_id, user, plants)
      include PushNotificationsService
      plant_nickname = Plant.find(plants.first.first)[:nickname]
      params = {
        :message => {
          :title => "Your plants are thirsty!",
          :body => "Your plant #{plant_nickname} needs watering!",
        },
        :subscription => user[:subscription]
      }
      send_webpush_notification(user_id, params)
    end

    @thirsty_plants.map do |user_id, plant|
      if plant.any?
        @subscriptions = Subscription.where(user_id: user_id)
        @subscriptions.each do |subscription|
          subscription = subscription[:subscription]
          user_hash = {
            :subscription => {
              :endpoint => subscription['endpoint'],
              :keys => {
                :p256dh => subscription['p256dh'],
                :auth => subscription['auth']
              },
            }
          }
          notify_user(user_id, user_hash, plant)
        end
      end
    end
    puts "\nThirsty plants: "
    puts @thirsty_plants.to_json
  end
end
