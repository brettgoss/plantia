class PlantsController < ApplicationController
  before_filter :authorize
  def index
    @user = User.find(current_user.id)
    @plants = @user.plants.all
  end

  def new
  	@plant = Plant.new
  end

  def show
    @plant = Plant.find params[:id]

    if @plant.user != User.find(current_user.id)
      redirect_to '/'# make this show an error.
    end

  end

  def create

  	@plant = Plant.new(product_params)
  	@plant.user = current_user
  	if @plant.save
      redirect_to [:plants], notice: 'Plant created!'
    else
      render :new
    end
  end

  def product_params
    params.require(:plant).permit(
      :nickname,
      :common_name,
      :light,
      :water_freq,
    )
  end

end
