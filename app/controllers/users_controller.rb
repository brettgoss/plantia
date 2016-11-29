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


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
