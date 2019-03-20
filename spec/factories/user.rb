# frozen_string_literal: true

FactoryBot.define do
  factory :user do |u|
    u.name { 'John Doe' }
    u.sequence(:email) { |n| "user#{n}@test.com"}
    u.password { 'testing' }
    u.password_confirmation { 'testing' }
  end
end
