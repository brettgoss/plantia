class PlantsController < ApplicationController
  def index
     @plants = Plant.order(id: :desc).all
  end

  def show
    @plant = Plant.find params[:id]
  end

  def create
  end

end
