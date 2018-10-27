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
    @plant = Plant.find(params[:id])
    @past_events = WaterEvent.where(plant_id: @plant.id)

    @plantlog = Plantlog.new
    @plantlogs = Plantlog.where(plant_id: @plant.id).order("created_at desc")

    if @plant.user != User.find(current_user.id)
      redirect_to '/'# make this show an error.
    end
  end

  def create
  	@plant = Plant.new(plant_params)
    @plant.user = current_user
    if @plant.save

      @event = WaterEvent.new({plant_id: @plant.id})
      @event.water_date = @plant.water_freq.days.from_now
      @event.save

      redirect_to dashboard_index_url, notice: 'Plant created!'
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
