class PlantlogsController < ApplicationController

  def index
    @plantlogs = Plantlog.all
  end

  def create
    logger.error "In plantlog controller"
    @plant = Plant.find(params[:plant_id])
    @plantlog = @plant.plantlogs.new(plantlog_params)

      if @plantlog.save!
      redirect_to @plant
    else
     redirect_to plant_path(@plant)
    end
  end

  def destroy
    @plant = Plant.find(params[:plant_id])
    @plantlog = @plant.plantlogs.find(params[:id])
    @plantlog.destroy
    redirect_to plant_path(@plant), notice: 'Plant deleted!'

  end

  private
    def plantlog_params
      params.require(:plantlog).permit(:logtime, :title, :logtext, :plant_id)
    end
end
