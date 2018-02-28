# frozen_string_literal: true

module V1
  class ErrorsController < BaseApiController
    def error_404
      error = { msg: 'Not Found' }
      render json: { success: false, error: error }, status: 404
    end
  end
end

