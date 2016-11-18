class UsersController < ApplicationController

    def new
  end

  def create
  end


private

  def user_params
    params.require(:user).permit(:name, :email, :password_digest)
  end

end
