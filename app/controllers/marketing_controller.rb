class MarketingController < ApplicationController
  def leaderboard
    RegenerateLeaderboard.perform_later

    @users = User.where('hashes_count IS NOT NULL').order('hashes_count DESC') 
  end

  def nodes
    @nodes = Node.order('pinged_at DESC, created_at DESC') 
  end

  def badge
    send_file 'public/badges/3.svg', type: 'image/svg+xml', disposition: 'inline'
  end

  def explore_projects
    @projects = Project.all
  end

  def logout
    clear_current_user

    redirect_to request.base_url
  end
end

