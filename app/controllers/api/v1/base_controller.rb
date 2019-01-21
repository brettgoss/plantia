# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  respond_to :json

  before_action :destroy_session, :authenticate_user, :set_user_id
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { status: 404, message: 'Not found' }, status: 404
  end

  private

  def destroy_session
    request.session_options[:skip] = true
  end

  def set_user_id
    @user_id = current_user&.id || User.where(uuid: @jwt_uuid).first.id
  end

  def authenticate_user
    if request.headers[:Authorization].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JsonWebToken.decode(token)
          @jwt_uuid = jwt_payload[:uuid]
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    else
      head :unauthorized
    end
  end
end
