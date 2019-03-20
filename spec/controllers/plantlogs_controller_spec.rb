# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlantlogsController, type: :controller do
  describe 'logged in access to plantlogs', type: :request do
    before do
      @user = FactoryBot.create :user
      @plant = FactoryBot.create(:plant, user: @user)
      @plantlog = FactoryBot.create(:plantlog, plant: @plant)
      login_as(@user)
    end

    it 'should allow plantlogs#index' do
      get plant_plantlogs_path plant_id: @plant.id
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end

    it 'should allow plantlogs#new' do
      get new_plant_plantlog_path plant_id: @plant.id
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end

    it 'should allow plantlogs#create' do
      plantlog_attributes = FactoryBot.attributes_for(:plantlog)
      expect do
        post plant_plantlogs_path plant_id: @plant.id, plantlog: plantlog_attributes
      end.to change(Plantlog, :count)
      expect(response).to redirect_to @plant
    end

    it 'should not allow plantlogs#create with invalid attributes' do
      plantlog_attributes = FactoryBot.attributes_for(:plantlog, title: '')
      expect do
        post plant_plantlogs_path plant_id: @plant.id, plantlog: plantlog_attributes
      end.to_not change(Plantlog, :count)
      expect(response).to redirect_to @plant
    end

    it 'should allow plantlogs#destroy' do
      expect do
        delete plant_plantlog_path id: @plantlog.id, plant_id: @plant.id
      end.to change(Plantlog, :count)
      expect(flash[:notice]).to_not be(nil)
      expect(response).to redirect_to @plant
    end
  end

  describe 'public access to plantlogs', type: :request do
    before do
      @user = FactoryBot.create :user
      @plant = FactoryBot.create(:plant, user: @user)
      @plantlog = FactoryBot.create(:plantlog, plant: @plant)
    end

    it 'denies access to plantlogs#index' do
      get plant_plantlogs_path plant_id: @plant.id
      expect(response).to redirect_to '/login'
    end

    # Skipping because there's no show action currently,
    # but there might be in the future
    # xit 'denies access to plantlogs#show' do
    #   get plant_plantlog_path id: @plantlog.id, plant_id: @plant.id
    #   expect(response).to redirect_to '/login'
    # end

    it 'denies access to plantlogs#new' do
      get new_plant_plantlog_path plant_id: @plant.id
      expect(response).to redirect_to '/login'
    end

    # Skipping because there's no edit action currently,
    # but there might be in the future
    # xit 'denies access to plantlogs#edit' do
    #   get edit_plant_plantlog_path plant_id: @plant.id
    #   expect(response).to redirect_to '/login'
    # end

    it 'denies access to plantlogs#create' do
      expect do
        post plant_plantlogs_path plant_id: @plant.id
      end.to_not change(Plantlog, :count)
      expect(response).to redirect_to '/login'
    end

    # Skipping because there's no update action currently,
    # but there might be in the future
    # xit 'denies access to plantlogs#update' do
    #   plantlog_attributes = FactoryBot.attributes_for(:plantlog, title: 'new')
    #   expect do
    #     patch plant_plantlog_path id: @plantlog.id, params: plantlog_attributes
    #   end.to_not change(Plantlog, :name)
    #   expect(response).to redirect_to '/login'
    # end

    it 'denies access to plantlogs#destroy' do
      expect do
        delete plant_plantlog_path id: @plantlog.id, plant_id: @plant.id
      end.to_not change(Plantlog, :count)
      expect(response).to redirect_to '/login'
    end
  end
end
