# frozen_string_literal: true

class ProjectController < ApplicationController
  layout 'minimal'

  def index
    @project = FindOrCreateProject.new(url: url).run

    raise ActiveRecord::RecordNotFound unless @project.present?
  end

  def new
    @new_project = NewProject.new
  end

  def create
    @new_project = NewProject.new(new_project_attrs)

    if @new_project.valid?
      @project = FindOrCreateProject.new(url: @new_project.url).run
      redirect_to project_path(url: @project.url)
    else
      render :new
    end
  end

  private

  def url
    params[:url]
  end

  def new_project_attrs
    params.require(:new_project).permit(:url)
  end
end
