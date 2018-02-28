# frozen_string_literal: true

module V1
  class ProjectController < BaseApiController
    # GET /project/balance
    def balance

      @project = FindOrCreateProject.new(url: url).run

      refresh_project_stats_in_background(@project.id)

      result = Coinhive::UserBalance.new(name: @project.url).run

      render json: result
    end

    private

    def url
      params[:url]
    end

    def refresh_project_stats_in_background(project_id)
      SetProjectStatsJob.perform_later(project_id)
    end
  end
end

