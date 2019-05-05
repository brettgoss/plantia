# frozen_string_literal: true

# Overrides Devise::RegistrationsController to perform serverside analytics on signup
class RegistrationsController < Devise::RegistrationsController
  def create
    super do |created_user|
      if created_user.id
        uuid = User.find(created_user.id).uuid
        GoogleAnalyticsService.call(
          GoogleAnalyticsService::Categories::USERS,
          GoogleAnalyticsService::Actions::SIGNUP,
          uuid
        )
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
