require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get '/auth/:provider/callback' => 'auth#callback'
  get '/auth/failure' => 'auth#failure'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'project' => 'project#index'
  get 'project/new' => 'project#new'
  post 'project' => 'project#create'

  resources :dashboard, only: [:index] do
    collection do
      get 'loading' => 'dashboard#loading'
      get 'refresh_stats' => 'dashboard#refresh_stats'
      get 'projects' => 'dashboard#projects'
    end
  end

  resources :documentation, only: [:index] do
    collection do
      get 'readme_badge' => 'documentation#readme_badge'
      get 'donation_page' => 'documentation#donation_page'
    end
  end

  scope module: :v1 do
    scope 'v1' do
      match 'node/ping' => 'node#ping', via: [:all]

      get 'project/balance' => 'project#balance'
      get 'stats/balance' => 'stats#balance'

      get 'poll/have_projects_loaded' => 'poll#have_projects_loaded'
      get 'poll/has_new_project_data' => 'poll#has_new_project_data'

      match '*path', to: 'errors#error_404', via: :all
    end
  end

  get 'help' => 'marketing#help'
  get 'badge' => 'marketing#badge'
  get 'getpaid' => 'marketing#getpaid'
  get 'mediakit' => 'marketing#mediakit'
  get 'explore/projects' => 'marketing#explore_projects'
  get 'login' => 'marketing#login'
  get 'join' => 'marketing#login'
  get 'signup' => 'marketing#login'
  get 'logout' => 'marketing#logout'
  get 'getstarted' => 'marketing#getstarted'
  get 'nodes' => 'marketing#nodes'
  get 'leaderboard' => 'marketing#leaderboard'
  get 'run/node' => 'marketing#run_node'
  get 'run/node/mac' => 'marketing#run_node_mac'
  get 'run/node/windows' => 'marketing#run_node_windows'
  get 'download/mac' => 'download#mac'
  get 'download/windows' => 'download#windows'

  # deprecated
  resources :onboarding, only: [:index] do
    collection do
      get 'step1' => 'onboarding#step1'
      get 'step2' => 'onboarding#step2'
      post 'step2/submit' => 'onboarding#step2_submit'
      get 'step3' => 'onboarding#step3'
      get 'login' => 'onboarding#login'
    end
  end



  root to: 'marketing#landing'
end
