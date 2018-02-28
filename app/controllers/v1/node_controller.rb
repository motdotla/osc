# frozen_string_literal: true

module V1
  class NodeController < BaseApiController
    # GET /node/ping
    def ping
      @node = FindOrCreateNode.new(machine_id: machine_id).run

      render json: { success: true }
    end

    private

    def machine_id
      params[:machine_id]
    end
  end
end

