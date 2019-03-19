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
    user_id { nil }
  end
end
