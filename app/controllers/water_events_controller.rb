class WaterEventsController < ApplicationController

  def create
    plant_id = params[:plant_id]

    e = create_water_event(plant_id)
    puts e
    if e.save
      puts "Saved!", plant_id
      render json: e, status: :ok
    else
      render json: e.errors, status: :unprocessable_entity
    end
  end

  def destroy
    e = WaterEvent.find(params[:id])
    e.destroy if e
    head :no_content
  end

  def create_water_event(plant_id)

    plant_hash = { plant_id: plant_id}
    e = WaterEvent.new(plant_hash)
    e.water_date = Time.now.utc
    e
  end

  def water_all
    plants = current_user.plants.all
    failed_plants = []
    success_plants = []

    plants.each do |plant|
      if create_water_event(plant.id.to_s).save
        success_plants.push(plant)
      else
        failed_plants.push(plant)
      end
    end

    if !success_plants.empty?
        response = { 'plant_id': 0}
        render json: response, status: :ok
    end
  end



  private

  #   def water_all_params
  #   params.require('/water_all').permit(:user_id)
  # end

  def water_event_params
    params.require(:water_event).permit(:plant_id, :water_date)
  end

end
