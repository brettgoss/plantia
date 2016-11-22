require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'Validations' do
    #Create stub user when testing
       user = User.create({
          name: "Aileen",
          email: "aileen@fake.com",
          password: "aileen",
          })

    it "is true with valid attributes" do

      plant = Plant.new({
                nickname:"test",
                common_name: "testy",
                light: "test test",
                water_freq: 2,
                })
      plant.user = user

        expect(plant.save).to be true
      end

    it "is false with no nickname" do

      plant = Plant.new({
                      nickname:"",
                      common_name: "testy",
                      light: "test test",
                      water_freq: 2,
                      })
      plant.user = user

        expect(plant.save).to be false
        # puts plant.errors.full_messages
      end

    it "is false with no common name" do

      plant = Plant.new({
                      nickname:"Test",
                      common_name: "",
                      light: "test test",
                      water_freq: 2,
                      })
      plant.user = user

        expect(plant.save).to be false
      end

    it "is false with no light requirements" do

      plant = Plant.new({
                      nickname:"Test",
                      common_name: "testy",
                      light: "",
                      water_freq: 2,
                      })
      plant.user = user

        expect(plant.save).to be false
      end
  end
end
