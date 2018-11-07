# require 'twilio_helper'
require 'seed_helper'
require 'json'

desc "This will be called only once on Heroku manually"
task :seed => :environment do
  seedhelper = SeedHelper.new
  seedhelper.seed_data
end

# TODO: Make this modular and move logic out of task
desc "This checks for plants that need watering and triggers the webpush notifications"
task :notify => :environment do
  def get_users_with_recently_watered_plants(num_days = 2)
    @users_with_thirsty_plants = {}
    users = User.all
    users.each do |user|
      water_events = user.water_events.where("water_date > ?", num_days.days.ago.beginning_of_day).to_a
      if water_events.any?
        @users_with_thirsty_plants["#{user.id}"] = water_events
      end
    end
  end

  def get_users_with_thirsty_plants
    @thirsty_plants = {}
    @users_with_thirsty_plants.map do |user, events|
      plants = {}
      events.each do |event|
        if (!plants.include? event.plant_id) && event.water_date <= DateTime.now
          plants["#{event.plant_id}"] = event.water_date
        elsif event.water_date > DateTime.now
          plants.delete("#{event.plant_id}")
        end
      end
      @thirsty_plants["#{user}"] = plants
    end
  end

  def notify_user(user, plants)
    include PushNotificationsService

    plant_nickname = Plant.find(plants.first.first)[:nickname]
    params = {
      :message => {
        :title => "Your plants are thirsty!",
        :body => "Your plant #{plant_nickname} needs watering!",
      },
      :subscription => user[:subscription]
    }
    send_webpush_notification(@user_id, params)
  end

  get_users_with_recently_watered_plants(2)
  get_users_with_thirsty_plants()

  @thirsty_plants.map do |user, plant|
    if plant.any?
      @user_id = user
      @subscriptions = Subscription.where(user_id: @user_id)
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
        notify_user(user_hash, plant)
      end
    end
  end
  puts "\nThirsty plants: "
  puts @thirsty_plants.to_json
end
