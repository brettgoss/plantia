class DashboardController < ApplicationController
  before_action :authorize
  helper_method :days_till_water

  def index
    puts(current_user.id)
    @user = User.find(current_user.id)
    @plants = @user.plants.all
    @water_events = WaterEvent.where(plant_id: @plants.ids)
  end

end
