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
    subscription_hash { '7cf011c4cfd2f2aebb509a37b8541006c0c1' }
    user_id { nil }
  end
end
