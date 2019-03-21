# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    sequence(:subscription) do |n|
      {
        endpoint: "https://fcm.googleapis.com/fcm/send/eT#{n}",
        keys: {
          auth: 'YXYtLGO',
          p256dh: 'BMaF-wSubZQQNGSzb5S-4lEh',
        }
      }
    end
    subscription_hash { '095bed1414b1ebe57e239f609eeb02b8b8d1f6ee21f74103002f8ca24174de33a7af90d78fcf21e25202bb5d8a2f9213d1fc924e1734c96067e2063278dd7dd9' }
    user_id { nil }
  end
end
