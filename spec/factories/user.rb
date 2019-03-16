# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'test@test.com' }
    password { 'testing' }
    password_confirmation { 'testing' }
  end
end
