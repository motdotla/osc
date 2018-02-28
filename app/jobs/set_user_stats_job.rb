class SetUserStatsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    SetUserStats.new(user_id: user_id).run
  end
end
