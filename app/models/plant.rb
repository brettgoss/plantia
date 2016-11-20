class Plant < ApplicationRecord
  belongs_to :user
  has_many :water_events

  validates :nickname, presence: true
  validates :common_name, presence: true
  validates :light, presence: true
  validates :water_freq, presence: true

end
