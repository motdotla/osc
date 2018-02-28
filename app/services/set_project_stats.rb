# frozen_string_literal: true

require 'uri'

class SetProjectStats
  attr_accessor :project_id

  def initialize(project_id:)
    self.project_id = project_id
  end

  def run
    if should_update?
      ActiveRecord::Base.transaction do
        project.update_column(:hashes_count, result['total'])

        project.users.each do |user|
          user.update_column(:has_new_project_data, true)
        end
      end
    end
  end

  private

  def result
    @result ||= Coinhive::UserBalance.new(name: project.url).run
  end

  def project
    @project ||= Project.find(project_id)
  end

  def hashes_count
    project.hashes_count.to_i
  end

  def should_update?
    result['total'] && hashes_count < result['total']
  end
end
