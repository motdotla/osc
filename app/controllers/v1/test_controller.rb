# frozen_string_literal: true

module V1
  class TestController < BaseApiController
    # GET /test
    def index
      render json: { success: true }
    end
  end
end

