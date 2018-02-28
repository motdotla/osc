class SetProjectStatsJob < ApplicationJob
  queue_as :default

  def perform(project_id)
    SetProjectStats.new(project_id: project_id).run
  end
end
