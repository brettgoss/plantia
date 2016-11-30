class Plant < ApplicationRecord
  belongs_to :user
  has_many :water_events, dependent: :destroy
  has_many :plantlogs, dependent: :destroy

  validates :nickname, presence: true
  validates :common_name, presence: true
  validates :light, presence: true
  validates :water_freq, presence: true,
                           numericality: {
                            only_integer: true,
                            less_than_or_equal_to: 365,
                            greater_than_or_equal_to: 0,
                          }

  def days_till_water
    latest_water = water_events.order(water_date: :desc).limit(1).first
    return 0 unless latest_water
    days_since_last_water = latest_water.water_date.to_date - Date.today
    (water_freq - days_since_last_water).to_i
  end

  # def water!
  #   # Done in water_events controller and is handling boolean events in water events table.
  #   # mark the current (most recent) water event as "done"
  #   # create the next water event (+ water_freq days from now, "done" = false)
  # end

  def self.needs_water
    users = User.all

    users.each do |user| # loop through all the users
      user.plant_ids.each do |plant|
       # each users plant_ids in and array [1,2,3,4]
       # plant.id = 1 plant.water_freq = 4



    end

    # loop through users then through users plant for each plant do a query for boolean value.
    # when you hit a plant that needs water log that user in a list and they will get a text.
    # hit plant that needs waters for a user, user text, then move on to text user (breaks loop)
    # not just false but also two days overdue

    # return all Plants needing watering
    # (do a query)
  end

end
