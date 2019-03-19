# frozen_string_literal: true

FactoryBot.define do
  factory :plantlog do
    logtime { DateTime.current }
    title { 'Moved to the window' }
    logtext { 'It needed more sun than it was getting' }
    plant { nil }
  end
end
