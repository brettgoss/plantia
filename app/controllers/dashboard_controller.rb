class DashboardController < ApplicationController
  before_action :authorize
  helper_method :days_till_water

  def index
    puts(current_user.id)
    @user = User.find(current_user.id)
    @plants = @user.plants.all
    @water_events = []
    @plants.each do |p|
      event = WaterEvent.where(plant_id: p.id).order(water_date: :desc).limit(1).first
      @water_events << event
    end
  end

end
