class WaterEventsController < ApplicationController

  def create
    e = WaterEvent.new(water_event_params)
    e.water_date = Time.now.utc
    if e.save
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

  private

  def water_event_params
    params.require(:water_event).permit(:plant_id, :water_date)
  end

end
