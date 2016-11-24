class PlantlogsController < ApplicationController

  def create
    logger.error "In plantlog controller"
    @plant = Plant.find(params[:plant_id])
    @plantlog = @plant.plantlogs.new(plantlog_params)

      if @plantlog.save!
      redirect_to @plant
    else
      redirect_to '/'
    end
    # redirect_to plant_path(@plant)
  end

  private
    def plantlog_params
      params.require(:plantlog).permit(:logtime, :title, :logtext, :plant_id)
    end
end
end

