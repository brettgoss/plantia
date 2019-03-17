# frozen_string_literal: true

FactoryBot.define do
  factory :plant do
    nickname { 'Planty' }
    common_name { 'Planty Planta' }
    light { 'Medium Rare' }
    water_freq { 2 }
  end
end
