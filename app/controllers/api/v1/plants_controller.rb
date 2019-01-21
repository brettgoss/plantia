# frozen_string_literal: true

class Api::V1::PlantsController < Api::V1::BaseController
  def index
    plants = Plant.where(user_id: @user.id)

    render json: plants, serializer_each: Api::V1::PlantSerializer
  end

  def show
    plant = Plant.where(id: params[:id], user_id: @user.id).first

    render json: plant, serializer: Api::V1::PlantSerializer
  end
end
