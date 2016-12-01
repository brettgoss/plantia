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


  # def self.needs_water
  #  return Plant.where("water_event.watered = 'false'")
  # end
end

