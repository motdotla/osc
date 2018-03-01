# frozen_string_literal: true

require 'uri'

class FindOrCreateNode
  attr_accessor :machine_id

  def initialize(machine_id:)
    self.machine_id = machine_id
  end

  def run
    node = existing_node ? existing_node : create_node

    node.save! if node

    node
  end

  private

  def existing_node
    @existing_node ||= Node.find_by(machine_id: machine_id).tap do |n|
      n.assign_attributes node_attrs if n
    end
  end

  def create_node
    @node ||= begin
      node = Node.create!(node_attrs)

      deliver_slack_notification

      node
    rescue ActiveRecord::RecordInvalid
      nil
    end
  end

  def node_attrs
    {
      machine_id: machine_id,
      pinged_at: Time.now.utc
    }.compact
  end

  def deliver_slack_notification
    DeliverSlackNotificationJob.perform_later(machine_id)
  end
end
