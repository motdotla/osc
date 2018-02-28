class RegenerateLeaderboard < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      SetUserStatsJob.perform_later(user.id)
    end
  end
end
