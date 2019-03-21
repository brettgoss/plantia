# frozen_string_literal: true

require 'rails_helper'
RSpec.describe PushNotificationsController, type: :controller do
  describe 'logged in access to webpush subscriptions', type: :request do
    before do
      @user = FactoryBot.create :user
      @push_params = FactoryBot.attributes_for(:subscription, user_id: @user.id)
      login_as(@user)
      ENV['VAPID_PUBLIC_KEY'] = 'key'
      ENV['VAPID_PRIVATE_KEY'] = 'key'
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
end
