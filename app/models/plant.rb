class Plant < ApplicationRecord
  belongs_to :user
  has_many :water_events, dependent: :destroy
  has_many :plantlogs

  validates :nickname, presence: true
  validates :common_name, presence: true
  validates :light, presence: true
  validates :water_freq, presence: true

  # Returns an integer number of days until the plant needs to
  # be watered again. If water date has passed then returns negative
  # number indicating how many days late the water would be.
  def days_till_water
    latest_water = water_events.order(water_date: :desc).limit(1).first
    return 0 unless latest_water
    days_since_last_water = latest_water.water_date.to_date - Date.today
    (water_freq - days_since_last_water).to_i
  end

end
