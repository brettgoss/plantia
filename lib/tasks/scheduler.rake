# require 'twilio_helper'
require 'seed_helper'
require 'json'

desc "This will be called only once on Heroku manually"
task :seed => :environment do
  seedhelper = SeedHelper.new
  seedhelper.seed_data
end

namespace :notifications do
  desc "Sends users a push notification if their plants are thristy"
  task :send_watering_notification => :environment do
    include PushNotificationsService

    dry_plant_subscriptions = Subscription.fetch_dry_plant_subscriptions
    dry_plant_subscriptions.each do |notification|
      subscription = JSON.parse(notification['subscription'])
      subscription_hash = {
        :endpoint => subscription['endpoint'],
        :keys => {
          :p256dh => subscription['p256dh'],
          :auth => subscription['auth']
        }
      }

      notify_user_of_thirsty_plant(notification, subscription_hash)
    end
  end
end
