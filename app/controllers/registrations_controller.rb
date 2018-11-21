class RegistrationsController < Devise::RegistrationsController

  def create
    super do |created_user|
      if created_user.id
        uuid = User.find(created_user.id).uuid
        GoogleAnalyticsService.new.event('users', 'signup', uuid)
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