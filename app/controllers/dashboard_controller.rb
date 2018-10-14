class DashboardController < ApplicationController
  before_action :authorize

  def index
    user = User.find(current_user.id)
    @water_events = []
    @plants = user.plants.all
    @plants.each do |p|
      @water_events << WaterEvent.where(plant_id: p.id).last
    end
  end

end
