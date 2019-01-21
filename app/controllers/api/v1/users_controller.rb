# frozen_string_literal: true

class Api::V1::UsersController < Api::V1::BaseController
  # TODO: Change this to /profile, since a user can't view another users info
  def index
    user = User.find(@user_id)

    render json: user, serializer: Api::V1::UserSerializer
  end

  def show
    render json: { status: 403, message: 'Forbidden' }, status: 403
  end
end
