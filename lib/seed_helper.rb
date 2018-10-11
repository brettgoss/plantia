class SeedHelper

  def seed_data
    User.create!({
      name: "Brett",
      email: "test@test.com",
      password: "test",
    })

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
      nickname:  "Lord of the Desert",
      common_name: "Cactus",
      light: "Direct Sunlight",
      water_freq: 24,
      user_id: 1
    })

    Plant.create!({
      nickname:  "Bub",
      common_name: "Orchid",
      light: "Indirect Sunlight",
      water_freq: 7,
      user_id: 1
    })

    WaterEvent.create!({
      plant_id: 1,
      water_date: Time.current
    })

    WaterEvent.create!({
      plant_id: 2,
      water_date: Time.current
    })

    WaterEvent.create!({
      plant_id: 3,
      water_date: Time.current
    })

    WaterEvent.create!({
      plant_id: 4,
      water_date: Time.current
    })
  end
end