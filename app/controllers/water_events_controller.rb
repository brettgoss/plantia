class WaterEventsController < ApplicationController

  # Handles request to water one plant
  def create
    plant_id = params[:plant_id]
    e = create_water_event(plant_id)

    if e.save
      plants = current_user.plants.all
      response = WaterEvent.where(plant_id: plants.ids)
      render json: response, status: :ok
    else
      render json: response.errors, status: :unprocessable_entity
    end
  end

  # Handles request to water all plants
  def water_all
    @plants = current_user.plants.all
    failed_plants = []
    success_plants = []

    @plants.each do |plant|
      if create_water_event(plant.id.to_s).save
        success_plants.push(plant)
      else
        failed_plants.push(plant)
      end
    end

    if !success_plants.empty?
      response = WaterEvent.where(plant_id: @plants.ids)
      render json: response, status: :ok
    end
  end

  # Attempt to create new water event
  def create_water_event(plant_id)
    plant_hash = { plant_id: plant_id}
    e = WaterEvent.new(plant_hash)
    @plant = Plant.find(plant_id)
    @plant.updated_at = Time.current
    @plant.save
    # Should be today plus water freq
    e.water_date = @plant.water_freq.days.from_now
    e
  end

  # Handles deletion of a water event
  def destroy
    @water_event = WaterEvent.find(params[:id])
    @water_event.destroy
    redirect_to plant_path(@water_event.plant)
  end


private
  def water_event_params
    params.require(:water_event).permit(:plant_id, :water_date)
  end
end
