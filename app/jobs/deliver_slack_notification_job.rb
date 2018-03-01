class DeliverSlackNotificationJob < ApplicationJob
  def perform(machine_id)
    notifier = Slack::Notifier.new ENV['SLACK_NOTIFICATION_URL'] do
      defaults channel: '#nodes',
               username: 'osc'
    end

    notifier.ping "👶 node `#{machine_id}` joined the network" if Rails.env.production?
  end
end
