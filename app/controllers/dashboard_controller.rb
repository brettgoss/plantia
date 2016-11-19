class DashboardController < ApplicationController
  before_action :authorize

  def index
    puts(current_user.id)
    @user = User.find(current_user.id)
    @plants = @user.plants.all
  end
end
