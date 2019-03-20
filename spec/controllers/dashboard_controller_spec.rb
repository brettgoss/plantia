# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  before do
    @user = FactoryBot.create :user
  end

  describe 'GET index' do
    context 'when the user is not logged in' do
      it 'should redirect to the login page' do
        get :index
        expect(response).to redirect_to('/login')
      end
    end

    context 'when the user is logged in' do
      it 'should show the dashboard with their plants' do
        @plant = FactoryBot.create :plant, user_id: @user.id
        login_as(@user)
        get :index
        expect(assigns(:plants)).to_not be(nil)
        expect(response).to render_template(:index)
      end

      it 'should show the dashboard with empty state' do
        login_as(@user)
        get :index
        expect(assigns(:plants).first[:nickname]).to include('Example')
        expect(response).to render_template(:index)
      end
    end
  end
end
