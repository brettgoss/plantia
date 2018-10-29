class Plantlog < ApplicationRecord
  belongs_to :plant, inverse_of: :plantlogs

  validates :title, presence: true
  validates :logtext, presence: true
end
