# frozen_string_literal: true

module V1
  class StatsController < BaseApiController
    # GET /stats/balance
    def balance
      result = Coinhive::StatsSite.new.run

      render json: result
    end
  end
end

