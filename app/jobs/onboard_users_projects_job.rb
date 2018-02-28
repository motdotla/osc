class OnboardUsersProjectsJob < ApplicationJob
  def perform(user_id)
    Onboarding::CreateProjects::Index.new(user_id: user_id).run
  end
end
