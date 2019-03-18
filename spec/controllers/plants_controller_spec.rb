# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlantsController, type: :controller do
  describe 'logged in access to plants', type: :request do
    before do
      @user = FactoryBot.create :user
      @plant = FactoryBot.create(:plant, user: @user)
      login_as(@user)
    end

    it 'should load the plants#index' do
      get plants_path
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end

    it 'should load plant#show' do
      get plant_path id: @plant.id
      expect(response.status).to eq(200)
      expect(response).to render_template(:show)
    end

    it 'should allow plant#new' do
      get new_plant_path id: @plant.id
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end

    it 'should allow plant#edit' do
      get edit_plant_path id: @plant.id
      expect(response.status).to eq(200)
      expect(response).to render_template(:edit)
    end

    it 'should allow plant#create' do
      plant_attributes = FactoryBot.attributes_for(:plant)
      expect do
        post plants_path plant: plant_attributes
      end.to change(Plant, :count).and change(WaterEvent, :count)
      expect(flash[:notice]).to_not be(nil)
      expect(response.status).to eq(302)
      expect(response).to redirect_to dashboard_index_path
    end

    it 'should allow plants#update' do
      plant_attributes = FactoryBot.attributes_for(:plant, water_freq: 50)
      expect do
        patch plant_path id: @plant.id, plant: plant_attributes
        @plant.reload
      end.to change(@plant, :water_freq)
      expect(response.status).to eq(302)
      expect(response).to redirect_to plant_path id: @plant.id
    end

    it 'should allow plants#destroy' do
      expect do
        delete plant_path id: @plant.id
      end.to change(Plant, :count)
      expect(flash[:notice]).to_not be(nil)
      expect(response.status).to eq(302)
      expect(response).to redirect_to plants_path
    end
  end

  describe 'public access to plants', type: :request do
    before do
      @user = FactoryBot.create :user
      @plant = FactoryBot.create(:plant, user: @user)
    end

    it 'denies access to plants#index' do
      get plants_path
      expect(response).to redirect_to '/login'
    end

    it 'denies access to plants#show' do
      get plant_path id: @plant.id
      expect(response).to redirect_to '/login'
    end

    it 'denies access to plants#new' do
      get new_plant_path
      expect(response).to redirect_to '/login'
    end

    it 'denies access to plants#edit' do
      get edit_plant_path id: @plant.id
      expect(response).to redirect_to '/login'
    end

    it 'denies access to plants#create' do
      plant_attributes = FactoryBot.attributes_for(:plant)
      expect do
        post plants_path plant: plant_attributes
      end.to_not change(Plant, :count)
      expect(response).to redirect_to '/login'
    end

    it 'denies access to plants#update' do
      plant_attributes = FactoryBot.attributes_for(:plant, name: 'new')
      expect do
        patch plant_path id: @plant.id, params: plant_attributes
      end.to_not change(Plant, :name)
      expect(response).to redirect_to '/login'
    end

    it 'denies access to plants#destroy' do
      expect do
        delete plant_path id: @plant.id
      end.to_not change(Plant, :count)
      expect(response).to redirect_to '/login'
    end
  end
end
