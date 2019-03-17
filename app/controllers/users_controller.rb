# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  helper UsersHelper
  # User Profile Page
  def index
    return unless current_user

    @user = current_user
    @plants = @user.plants.all
  end
end
