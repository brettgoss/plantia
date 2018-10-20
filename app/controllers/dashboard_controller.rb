class DashboardController < ApplicationController
  before_action :authorize

  def index
    user = User.find(current_user.id)
    @water_events = []
    @plants = user.plants.all

    if @plants.present?
      @plants.each do |plant|
        @water_events << WaterEvent.where(plant_id: plant.id).last
      end
    else
      handle_empty_state
    end
  end

private
  def handle_empty_state
    water_freq = 1
    @plants = [Plant.new({
      :id => 0,
      :nickname => 'Example',
      :common_name => 'Plant',
      :light => 'Indirect Sunlight',
      :water_freq => water_freq,
      :user_id => current_user.id
    })]
    water_date = Time.now + water_freq.days
    @water_events = [WaterEvent.new(:plant_id => 0, :water_date => water_date)]
  end

end
