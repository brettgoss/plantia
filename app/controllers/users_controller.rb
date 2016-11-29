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
    @user = User.find(current_user.id)

    # Attempts to update user's phone number with new value from form
    if @user.update_column(:phone_number, params[:user][:phone_number])
      redirect_to '/plants'
    else
      # Show error or something.
      redirect_to '/plants'
    end
  end

  # def edit
  #   @user= User.find(current_user.id)
  # end
end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number)
  end
