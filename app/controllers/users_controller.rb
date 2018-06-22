class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # User Page
  def index
    @user = current_user
    @plants = @user.plants.all
  end

  # Signup Logic
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      # ApplicationMailer.send_signup_email(@user).deliver
      redirect_to '/plants'
    else
      render '/welcome/index'
    end

  end

  def update
    current_user.phone_number = user_params[:phone_number]
    current_user.save!
    redirect_to '/plants'
  end
end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number)
  end
