class DashboardController < ApplicationController
  before_action :authorize

  def index
    @plants = Plant.all
  end
end
