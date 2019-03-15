# frozen_string_literal: true

class Api::V1::TokenController < Api::V1::BaseController
  skip_before_action :authenticate_user

  def index
    tokens = current_user.tokens

    render json: tokens
  end

  def create
    token = current_user.generate_token
    payload = { uuid: params[:uuid] }
    jwt = JsonWebToken.encode(payload)
    render json: jwt
  end
end