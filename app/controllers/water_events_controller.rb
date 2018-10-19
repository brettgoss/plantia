class WaterEventsController < ApplicationController

  # Handles request to water one plant
  def create
    plant_id = params[:plant_id]
    e = create_water_event(plant_id)

    if e.save
      @water_events = []
      @plants = current_user.plants.all

      if @plants.present?
        @plants.each do |plant|
          @water_events << WaterEvent.where(plant_id: plant.id).last
        end
      end
      response = @water_events
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
      response = WaterEvent.where(plant_id: @plants.ids, watered: false)
      render json: response, status: :ok
    end
  end

  # Attempt to create new water event
  def create_water_event(plant_id)
    @last_event = WaterEvent.where(plant_id: plant_id).order(water_date: :desc).limit(1).first
    @last_event.watered = true
    @last_event.save

    plant_hash = { plant_id: plant_id}
    event = WaterEvent.new(plant_hash)

    @plant = Plant.find(plant_id)
    @plant.save

    # Should be today plus water freq
    event.water_date = DateTime.now + @plant.water_freq.days
    event
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
