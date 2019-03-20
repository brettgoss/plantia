# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET index' do
    it 'should load profile page if the user is signed in' do
      @user = FactoryBot.create :user
      login_as(@user)
      get :index

      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end

    it 'should redirect to the login page if the user is not signed in' do
      get :index

      expect(response.status).to eq(302)
      expect(response).to redirect_to('/login')
    end
  end
end
