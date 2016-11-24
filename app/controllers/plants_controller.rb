class PlantsController < ApplicationController
  before_action :authorize

  def index
    @user = User.find(current_user.id)
    @plants = @user.plants.all
  end

  def new
  	@plant = Plant.new
  end

  def show
    logger.error "Here we are!"
    @plant = Plant.find params[:id]
    @plantlog = Plantlog.new
    @plantlogs = Plantlog.all
    if @plant.user != User.find(current_user.id)
      redirect_to '/'# make this show an error.
    end
  end

  def create
  	@plant = Plant.new(plant_params)
  	@plant.user = current_user
  	if @plant.save
      redirect_to [:plants], notice: 'Plant created!'
    else
      render :new
    end
  end

  def update
    @plant = Plant.find(params[:id])

    if @plant.update(plant_params)
      redirect_to @plant
    else
      render 'edit'
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def destroy
    @plant = Plant.find params[:id]
    @plant.destroy
    redirect_to [:plants], notice: 'Plant deleted!'
  end

#this is now being handled by water controller
  # def water_event
  #   @event = WaterEvent.new
  #   @plant = Plant.find params[:id]
  #   @event.plant = @plant
  #   if @event.save
  #     redirect_to [:plants], notice: 'Plant Watered'
  #   else
  #     render :plants
  #   end
  # end

private
  def plant_params
    params.require(:plant).permit(
      :nickname,
      :common_name,
      :light,
      :water_freq
    )
  end

end
