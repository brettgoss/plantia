class PlantlogsController < ApplicationController
  before_action :authorize

  def index
    plant = Plant.find(params[:plant_id])
    @plantlogs = plant.plantlogs
    respond_to do |format|
      format.html
      format.json { render :json => @plantlogs }
    end
  end

  def new
    plant = Plant.find(params[:plant_id])
    @plantlog = plant.plantlogs.build
    respond_to do |format|
      format.html
      format.json { render :json => @plantlog }
    end
  end
  
  def create
    plant = Plant.find(params[:plant_id])
    @plantlog = plant.plantlogs.create(plantlog_params)

    respond_to do |format|
      if @plantlog.save
        format.html { redirect_to(plant, :notice => 'Plantlog was successfully created.') }
        format.json { render :json => @plantlog, :status => :created, :location => [@plantlog.plant, @plantlog] }
      else
        format.html { redirect_to(plant) }
        format.json { render :json => @plantlog.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    plant = Plant.find(params[:plant_id])
    @plantlog = plant.plantlogs.find(params[:id])
    @plantlog.destroy

    respond_to do |format|
      format.html { redirect_to(plant, :notice => 'Plantlog was successfully deleted.') }
      format.json { head :ok }
    end  
  end

private
  def plantlog_params
    params.require(:plantlog).permit(:logtime, :title, :logtext, :plant_id)
  end
end
