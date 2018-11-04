class Subscription < ApplicationRecord
  belongs_to :user
  validates :subscription, presence: true
  validates :user_id, presence: true
end