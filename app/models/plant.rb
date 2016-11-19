class Plant < ApplicationRecord
  belongs_to :user

  validates :nickname, presence: true
  validates :common_name, presence: true
  validates :light, presence: true
  validates :water_freq, presence: true
  
end
