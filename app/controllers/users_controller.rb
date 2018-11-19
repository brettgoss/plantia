class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  helper UsersHelper
  # User Profile Page
  def index
    if !current_user
      redirect_to(root_path)
    else
      @user = current_user
      @plants = @user.plants.all
    end
  end
end
