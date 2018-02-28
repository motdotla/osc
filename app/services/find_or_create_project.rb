# frozen_string_literal: true

require 'uri'

class FindOrCreateProject
  include Shared::NormalizedUrl

  attr_accessor :url, :user_id, :stars_count, :language

  def initialize(url:, user_id: nil, stars_count: nil, language: nil)
    self.user_id = user_id
    self.url = url
    self.stars_count = stars_count
    self.language = language
  end

  def run
    project = existing_project ? existing_project : create_project

    create_user_project(project.id) if should_associate_to_user?(project)

    project.save! if project

    project
  end

  private

  def should_associate_to_user?(project)
    user_id.present? && project && !existing_user_project(project.id)
  end

  def existing_project
    @existing_project ||= Project.find_by(url: normalized_url).tap do |p|
      p.assign_attributes project_attrs if p
    end
  end

  def create_project
    @project ||= begin
      Project.create!(project_attrs)
    rescue ActiveRecord::RecordInvalid
      nil
    end
  end

  def existing_user_project(project_id)
    UserProject.find_by(user_id: user_id, project_id: project_id)
  end

  def create_user_project(project_id)
    UserProject.create!(user_id: user_id, project_id: project_id)
  end

  def project_attrs
    {
      url: normalized_url,
      stars_count: stars_count,
      language: language
    }.compact
  end
end
