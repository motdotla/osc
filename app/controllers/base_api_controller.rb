class BaseApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action  :verify_authenticity_token

  before_action :log_params

  rescue_from ActionController::ParameterMissing, with: -> { render_missing_parameters }
  rescue_from ActionController::RoutingError, with: -> { render_404  }
  rescue_from ActionController::UnknownController, with: -> { render_404  }
  rescue_from ActiveRecord::RecordNotFound,        with: -> { render_404  }

  private

  def error_generic(exception)
    render json: {
      success: false,
      data: exception.data
    },
    status: exception.status
  end

  def log_params
    Rails.logger.debug params.inspect
  end

  def render_missing_parameters
    error = { msg: 'Missing parameters' }
    render json: { success: false, error: error }, status: 400
  end

  def render_404
    error = { msg: 'Not Found' }
    render json: { success: false, error: error }, status: 404
  end
end

