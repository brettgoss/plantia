class WaterEventsController < ApplicationController

  def create
    plant_id = params[:plant_id]
    if create_water_event(plant_id)
      render json: e
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
    plant_hash = {plant_id: plant_id}
    e = WaterEvent.new(plant_hash)
    e.water_date = Time.now.utc
    return e.save
  end

  def water_all
    plantaroos = current_user.plants.all
    failed_plantaroos = []

    plantaroos.each do |plant|
      if !create_water_event(plant.id)
        failed_plantaroos.push(plant)
      end
    end

    if !failed_plantaroos.empty?
      puts "VIOLENT EEEEEENDS" #IN FUTURE TELL USER ABOUT THESE FAILED PLANTS
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
