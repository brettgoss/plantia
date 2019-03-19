# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST create' do
    it 'should create a new user with valid params' do
      @user_attrs = FactoryBot.attributes_for :user
      post :create, params: { user: @user_attrs }

      expect(assigns(:user)).to be_a(User)
      expect(assigns(:user)[:created_at]).to_not be(nil)
      expect(response).to redirect_to(:authenticated_root)
    end

    it 'should return an error and not create a user with no name' do
      @user_attrs = FactoryBot.attributes_for :user
      @user_attrs[:name] = ''
      post :create, params: { user: @user_attrs }

      expect(assigns(:user)[:created_at]).to be(nil)
      expect(response).to render_template(:new)
    end
  end
end
