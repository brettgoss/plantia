class DashboardController < ApplicationController
  before_action :authorize

  def index
    puts(current_user.id)
    @user = User.find(current_user.id)
    @plants = Plant.where(user_id: @user.id)
    @water_events = WaterEvent.where(plant_id: @plants.ids)
    render component: 'App', props: { plants: @plants, water: @water_events }, tag: 'div', class: 'dashboard'

  end
end
