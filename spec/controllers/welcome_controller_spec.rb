# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET index' do
    context 'when the user is logged in' do
      it 'should load welcome page' do
        @user = FactoryBot.create :user
        login_as(@user)
        get :index

        expect(response.status).to eq(200)
        expect(response).to render_template(:index)
      end
    end
  end
end
