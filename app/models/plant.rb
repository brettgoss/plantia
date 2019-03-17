# frozen_string_literal: true

class Plant < ApplicationRecord
  belongs_to :user
  has_many :water_events, dependent: :destroy
  has_many :plantlogs, dependent: :destroy, inverse_of: :plant
  accepts_nested_attributes_for :plantlogs, reject_if: :all_blank,
                                            allow_destroy: true
  validates_associated :plantlogs

  validates :nickname, presence: true
  validates :common_name, presence: true
  validates :light, presence: true
  validates :water_freq, presence: true,
                         numericality: {
                           less_than_or_equal_to: 365,
                           greater_than_or_equal_to: 0
                         }
end
