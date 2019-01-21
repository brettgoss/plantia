# frozen_string_literal: true

class Api::V1::BaseController < ActionController::API
  before_action :destroy_session, :scope_user
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def destroy_session
    request.session_options[:skip] = true
  end

  def scope_user
    @user = current_user
  end

  def not_found
    render json: { status: 404, message: 'Not found' }, status: 404
  end
end
