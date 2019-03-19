# frozen_string_literal: true

class PlantsController < ApplicationController
  before_action :authenticate_user!
  include WaterEventsHelper

  def index
    @user = User.find(current_user.id)
    @plants = @user.plants.all
  end

  def show
    @plant = Plant.where(id: params[:id], user_id: current_user.id).first

    if @plant
      @past_events = WaterEvent.where(plant_id: @plant.id)
      @plantlog    = Plantlog.new
      @plantlogs   = Plantlog.where(plant_id: @plant.id).order('created_at desc')
    else
      redirect_to plants_path
    end
  end

  def new
    @plant = Plant.new
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def create
    @plant = Plant.new(plant_params)
    @plant.user = current_user

    if @plant.save
      create_water_event(@plant)
      redirect_to dashboard_index_path, notice: 'Plant created!'
    else
      render :new
    end
  end

  def update
    @plant = Plant.find(params[:id])

    if @plant.update(plant_params)
      redirect_to @plant
    else
      render :edit
    end
  end

  def destroy
    @plant = Plant.find params[:id]
    @plant.destroy
    redirect_to [:plants], notice: 'Plant deleted!'
  end

  private

  def plant_params
    params.require(:plant).permit(
      :nickname,
      :common_name,
      :light,
      :water_freq
    )
  end
end
