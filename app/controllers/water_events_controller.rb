class WaterEventsController < ApplicationController
  def create
    if params[:plant_id]
      water_one_plant()
    else
      water_all_plants()
    end

    @plants = current_user.plants.all
    @water_events = []

    @plants.each do |plant|
      @water_events << WaterEvent.where(plant_id: plant.id).last()
    end

    response = @water_events
    render json: response, status: :ok
  end

  def destroy
    @water_event = WaterEvent.find(params[:id])
    @water_event.destroy
    redirect_to plant_path(@water_event.plant)
  end

private
  def water_one_plant
    plant = Plant.find(params[:plant_id])
    helpers.create_water_event(plant)
  end

  def water_all_plants
    plants = current_user.plants.all
    plants.each do |plant|
      helpers.create_water_event(plant)
    end
  end
end