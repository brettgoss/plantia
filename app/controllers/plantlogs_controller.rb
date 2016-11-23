class PlantlogsController < ApplicationController

  def create
    @plant = Plant.find(params[:plant_id])
    @plantlog = @plant.plantlogs.create(plantlog_params)

      if @plantlog.save!
      redirect_to @plant
    else
      redirect_to @plant
    end
    # redirect_to plant_path(@plant)
  end

  private
    def comment_params
      params.require(:plantlog).permit(:logtime, :text, :title)
    end
end
end

