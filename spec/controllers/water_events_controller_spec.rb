# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WaterEventsController, type: :controller do
  before do
    @user = FactoryBot.create :user
    @plant = FactoryBot.create(:plant, user: @user)
    @plant2 = FactoryBot.create(:plant, user: @user)
    login_as(@user)
  end

  describe 'POST create' do
    it 'should create a water event if a plant_id is specified' do
      post :create, params: { plant_id: @plant.id }

      res = JSON.parse(response.body)
      expect(res).to_not be_empty
      expect(res.first['id']).to eq(@plant.water_events.last.id)
      expect(@plant2.water_events.first).to be(nil)
      expect(assigns(:water_events).first[:created_at]).to_not be(nil)
    end

    it 'should water all plants if no plant_id is specified' do
      post :create

      res = JSON.parse(response.body)
      expect(res).to_not be_empty
      expect(res.first['id']).to eq(@plant.water_events.first.id)
      expect(res.last['id']).to eq(@plant2.water_events.first.id)
      expect(assigns(:water_events).first).to eq(assigns(:water_events).first)
      expect(assigns(:water_events).first).to_not eq(assigns(:water_events).last)
    end
  end

  describe 'DELETE destroy' do
    it 'should delete the water event specified by water event ID' do
      post :create, params: { plant_id: @plant.id }
      post :create, params: { plant_id: @plant.id }

      water_event_before = WaterEvent.where(plant_id: @plant.id).take
      delete :destroy, params: { id: water_event_before.id }
      water_event_after = WaterEvent.where(plant_id: @plant.id).take

      expect(water_event_after).to_not be(nil)
      expect(water_event_before.created_at).to_not eq(water_event_after.created_at)
    end

    it 'should error without a valid water event ID' do
      delete :destroy, params: { id: 1000 }
      expect(response.status).to_not eq(200)
    end
  end
end
