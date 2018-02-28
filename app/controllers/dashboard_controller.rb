class DashboardController < ApplicationController
  layout 'dashboard'

  before_action :authenticate_user

  def index
  end

  def projects
    @projects = current_user.projects
    @hashes_count_sum = @projects.sum(:hashes_count)
  end

  def loading
    current_user.update_column(:has_new_project_data, false)

    OnboardUsersProjectsJob.perform_later current_user.id
  end
end
