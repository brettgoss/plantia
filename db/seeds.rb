# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeding Data..."

raise "Development seeds only (for now)!" unless Rails.env.development?

puts "Creating Users"

User.create!({
  name: "Aileen",
  email: "aileen@fake.com",
  password: "aileen",
  })

User.create!({
  name: "Brett",
  email: "brett@fake.com",
  password: "brett",
  })

User.create!({
  name: "Kim",
  email: "kim@fake.com",
  password: "kimmy",
  })

User.create!({
  name: "Linley",
  email: "linley@fake.com",
  password: "linley",
  })

puts "Seeding Plants!(LOL!!)"

Plant.create!({
  nickname:  "Mittens",
  common_name: "Venus Flytrap",
  light: "Direct Sunlight",
  water_freq: 4,
  user_id: 1
})

Plant.create!({
  nickname:  "Fernie Sanders",
  common_name: "Maiden Hair Fern",
  light: "Indirect Sunlight",
  water_freq: 1,
  user_id: 1
})

Plant.create!({
  nickname:  "Sparky",
  common_name: "Succulent",
  light: "Direct Sunlight",
  water_freq: 5,
  user_id: 1
})

Plant.create!({
  nickname:  "Finnegan",
  common_name: "Norfolk Pine",
  light: "Indirect Sunlight",
  water_freq: 7,
  user_id: 1
})

Plant.create!({
  nickname:  "Frankie",
  common_name: "Ficus",
  light: "Direct Sunlight",
  water_freq: 7,
  user_id: 2
})

Plant.create!({
  nickname:  "Kaa",
  common_name: "Snake Plant",
  light: "Direct Sunlight",
  water_freq: 14,
  user_id: 3
})

Plant.create!({
  nickname:  "Linley jr.",
  common_name: "Aloe",
  light: "Indirect Sunlight",
  water_freq: 7,
  user_id: 4
})

Plantlog.create!({
  logtime: "2016-04-05",
  title:"Pruning",
  logtext: "Pruned Kaa. Looking so fresh and clean",
  plant_id: 6
  })

puts " One Single Plant log created!"
