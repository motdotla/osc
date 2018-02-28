class OnboardingController < ApplicationController
  layout 'minimal'

  def index
    github = Github.new

    @repos = fetch_repos
  end

  def step1
  end

  def step2
    @new_project = NewProject.new

    @repos = fetch_repos
  end

  def step2_submit
    @new_project = NewProject.new(new_project_attrs)

    @repos = fetch_repos

    if @new_project.valid?
      @project = FindOrCreateProject.new(url: @new_project.url).run

      redirect_to "/onboarding/step3?url=#{@project.url}"
    else
      render :step2
    end
  end

  def step3
    @project = FindOrCreateProject.new(url: params[:url]).run
  end

  def login
    redirect_to '/login'
  end

  private

  def github
    @github ||= Github.new
  end

  def new_project_attrs
    params.require(:new_project).permit(:url)
  end

  def fetch_repos
    github.repos.list user: current_user.nickname, type: 'owner', sort: 'updated'
  end
end


