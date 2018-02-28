# frozen_string_literal: true

module V1
  class PollController < BaseApiController
    def have_projects_loaded
      authenticate_user

      result = { success: current_user.projects.exists? }

      render json: result
    end

    def has_new_project_data
      authenticate_user

      result = { success: current_user.has_new_project_data? }

      render json: result
    end
  end
end

