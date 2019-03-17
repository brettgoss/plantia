# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plant, type: :model do
  before do
    @user = FactoryBot.create :user
    @plant = FactoryBot.build :plant
    @plant.user = @user
  end

  describe 'Successful validations' do
    context 'with all parameters' do 
      it 'should save with all valid attributes' do
        expect(@plant.save).to be true
      end
    end
  end

  describe 'Unsuccessful validations' do
    context 'with missing parameters' do
      it 'should not save with no user associated' do
        @plant.user = nil
        expect(@plant.save).to be false
      end

      it 'should not save with no nickname' do
        @plant.nickname = ''
        expect(@plant.save).to be false
      end

      it 'should not save with no common name' do
        @plant.common_name = ''
        expect(@plant.save).to be false
      end

      it 'should not save with no light requirements' do
        @plant.light = ''
        expect(@plant.save).to be false
      end

      it 'should not save with no water frequency' do
        @plant.water_freq = nil
        expect(@plant.save).to be false
      end

      it 'should not save with a water frequency greater than 1 year' do
        @plant.water_freq = 400
        expect(@plant.save).to be false
      end

      it 'should not save with a non-numeric water frequency' do
        @plant.water_freq = 'string'
        expect(@plant.save).to be false
      end
    end
  end
end
