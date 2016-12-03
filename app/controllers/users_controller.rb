class UsersController < ApplicationController

  # Signup Logic
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ApplicationMailer.send_signup_email(@user).deliver
      redirect_to '/plants'
    else
      render '/welcome/index'
    end

  end

  def update
    # Gets current user and saves as instance variable

    current_user.phone_number = user_params[:phone_number]
    # Attempts to update user's phone number with new value from form
    current_user.save!
    redirect_to '/plants'
  end

  # def edit
  #   @user= User.find(current_user.id)
  # end
end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number)
  end
