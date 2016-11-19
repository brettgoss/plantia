class PlantsController < ApplicationController
  before_filter :authorize
  def index
    @plants = Plant.all
  end

  def new
  	@plants = Plant.new
  end

  def show
    @plant = Plant.find params[:id]
  end

  def create
  	@plant = Plant.new(product_params)

  	if @plant.save
      redirect_to [:plants], notice: 'Plant created!'
    else
      render :new
    end
  end

  def product_params
    params.require(:plant).permit(
      :name,
      :common_name,
      :light,
      :water_freq,
    )
  end

end
