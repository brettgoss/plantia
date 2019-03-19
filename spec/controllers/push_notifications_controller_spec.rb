# frozen_string_literal: true

require 'rails_helper'
RSpec.describe PushNotificationsController, type: :controller do
  describe 'logged in access to webpush subscriptions', type: :request do
    before do
      @user = FactoryBot.create :user
      @push_params = FactoryBot.attributes_for(:subscription, user_id: @user.id)
      login_as(@user)
    end

    it 'should allow #create' do
      allow(Webpush).to receive(:payload_send)

      expect do
        post push_path params: {
          subscription: @push_params[:subscription],
          message: {
            title: 'testing',
            body: 'message body'
          }
        }
      end.to_not change(Subscription, :count)
      expect(response.status).to eq(200)

      expect do
        post push_path params: @push_params
      end.to_not change(Subscription, :count)
      expect(response.status).to eq(404)
    end

    it 'should allow #subscribe and error if duplicate subscription' do
      expect do
        post subscribe_path params: @push_params
      end.to change(Subscription, :count)
      expect(response.body).to include('success')

      expect do
        post subscribe_path params: @push_params
      end.to_not change(Subscription, :count)
      expect(response.body).to include('failed')
    end

    it 'should allow #destroy and error is no subscription found' do
      # A new user is created per test, so we need to subscribe this user
      # in order to unsubscribe them
      expect do
        post subscribe_path params: @push_params
      end.to change(Subscription, :count)

      expect do
        delete unsubscribe_path params: @push_params
      end.to change(Subscription, :count)
      expect(response.status).to eq(200)
      expect(response.body).to include('success')

      expect do
        delete unsubscribe_path params: @push_params
      end.to_not change(Subscription, :count)
      expect(response.status).to eq(200)
      expect(response.body).to include('failed')
    end
  end

  # describe 'public access to plants', type: :request do
  #   before do
  #     @user = FactoryBot.create :user
  #     @plant = FactoryBot.create(:plant, user: @user)
  #   end

  #   it 'denies access to plants#index' do
  #     get plants_path
  #     expect(response).to redirect_to '/login'
  #   end

  #   it 'denies access to plants#show' do
  #     get plant_path id: @plant.id
  #     expect(response).to redirect_to '/login'
  #   end

  #   it 'denies access to plants#new' do
  #     get new_plant_path
  #     expect(response).to redirect_to '/login'
  #   end

  #   it 'denies access to plants#edit' do
  #     get edit_plant_path id: @plant.id
  #     expect(response).to redirect_to '/login'
  #   end

  #   it 'denies access to plants#create' do
  #     plant_attributes = FactoryBot.attributes_for(:plant)
  #     expect do
  #       post plants_path plant: plant_attributes
  #     end.to_not change(Plant, :count)
  #     expect(response).to redirect_to '/login'
  #   end

  #   it 'denies access to plants#update' do
  #     plant_attributes = FactoryBot.attributes_for(:plant, name: 'new')
  #     expect do
  #       patch plant_path id: @plant.id, params: plant_attributes
  #     end.to_not change(Plant, :name)
  #     expect(response).to redirect_to '/login'
  #   end

  #   it 'denies access to plants#destroy' do
  #     expect do
  #       delete plant_path id: @plant.id
  #     end.to_not change(Plant, :count)
  #     expect(response).to redirect_to '/login'
  #   end
  # end
end
