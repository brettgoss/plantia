# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# puts "Seeding Data..."

# raise "Development seeds only (for now)!" unless Rails.env.development?

User.create!(
  name: 'Test',
  email: 'test@fake.com',
  password: 'testing'
)

Subscription.create(
  subscription_hash: '3e01f89cdd072b1fe1c423896a09d9a51b5c8a24c4eebef0c6acb158fd1da2566bb8e9ad17aa5cdc01ae85f67cc88f8b9272557f7ccee7198931219b873a6177',
  subscription: {
    "endpoint": 'https://fcm.googleapis.com/fcm/send/eTEfeepZIwk',
    "p256dh": 'BMaF-wSubZQQNGSzb5S',
    "auth": 'YXYtLGO'
  },
  user_id: 1,
)

Plant.create!(
  nickname: 'Mittens',
  common_name: 'Venus Flytrap',
  light: 'Direct Sunlight',
  water_freq: 4,
  user_id: 1
)

WaterEvent.create!(
  plant_id: 1,
  water_date: Time.current
)

Plantlog.create!(
  logtime: '2016-04-05',
  title: 'Pruning',
  logtext: 'Pruned Mittens. Looking so fresh and clean',
  plant_id: 1
)