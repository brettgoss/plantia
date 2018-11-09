require 'json'

namespace :notifications do
  desc "Sends users a push notification if their plants are thristy"
  task :send_watering_notification, [:days_since_watered] => :environment do |task, args|
    include PushNotificationsService

    days_since_watered = args[:days_since_watered] ? args[:days_since_watered].to_i : 2
    dry_plant_subscriptions = Subscription.fetch_dry_plant_subscriptions(days_since_watered)
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
