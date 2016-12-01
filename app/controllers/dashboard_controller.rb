class DashboardController < ApplicationController
  before_action :authorize
  helper_method :days_till_water

  def index
    puts(current_user.id)
    @user = User.find(current_user.id)
    @plants = @user.plants.all
    @water_events = []
    @plants.each do |p|
      event = WaterEvent.where(plant_id: p.id, watered: false).first
      @water_events << event
    end
  end

end
