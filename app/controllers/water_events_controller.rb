# frozen_string_literal: true

class WaterEventsController < ApplicationController
  def create
    params[:plant_id] ? water_one_plant : water_all_plants
    @plants = current_user.plants.all
    @water_events = []

    @plants.each do |plant|
      @water_events << WaterEvent.where(plant_id: plant.id).last
    end

    render json: @water_events, status: :ok
  end

  def destroy
    @water_event = WaterEvent.find(params[:id])
    @water_event.destroy
    redirect_to plant_path(@water_event.plant)
  rescue ActiveRecord::RecordNotFound
    redirect_to plant_path, notice: 'Attempted to delete a water event that does not exist'
  end

  private

  def water_one_plant
    plant = Plant.find(params[:plant_id])
  rescue ActiveRecord::RecordNotFound
    logger.error('Attempted to water a plant that does not exist')
  else
    helpers.create_water_event(plant) if plant.present?
  end

  def water_all_plants
    plants = current_user.plants.all
    plants.each do |plant|
      helpers.create_water_event(plant)
    end
  end
end
