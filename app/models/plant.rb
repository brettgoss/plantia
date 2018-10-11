class Plant < ApplicationRecord
  belongs_to :user
  has_many :water_events, dependent: :destroy
  has_many :plantlogs, dependent: :destroy

  validates :nickname, presence: true
  validates :common_name, presence: true
  validates :light, presence: true
  validates :water_freq, presence: true,
            numericality: {
              less_than_or_equal_to: 365,
              greater_than_or_equal_to: 0,
            }
end

