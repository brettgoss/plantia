class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  helper UsersHelper
  # User Page
  def index
    if !current_user
      redirect_to(root_path)
    else
      @user = current_user
      @plants = @user.plants.all
    end
  end

  # Signup Logic
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(dashboard_index_path)
    else
      redirect_to(root_path)
    end

  end

  def update
    current_user.save!
    redirect_to '/plants'
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
