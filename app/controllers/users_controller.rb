class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ApplicationMailer.send_signup_email(@user).deliver
      redirect_to '/dashboard' #redirectooo to dashboard in future
    else
      render '/welcome/index'
    end
  end

  def update
    @user  = User.find(current_user.id)

    if @user.update(user_params)
      redirect_to '/plants'
    else
      render 'edit'
    end
  end

  def edit
    @user= User.find(current_user.id)
  end
end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number)
  end
