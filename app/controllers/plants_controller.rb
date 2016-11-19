class PlantsController < ApplicationController
  before_filter :authorize
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find params[:id]
  end

  def create
  end

end
