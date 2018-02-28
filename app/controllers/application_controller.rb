class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :set_the_meta_tags

  private

  def authenticate_user
    error = 'You must <a href="/getstarted">create your citizenship</a> (or <a href="/login">log in</a>) first.'

    redirect_back(fallback_location: root_path, flash: { error: error }) unless current_user
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end
  
  def clear_current_user
    session[:user_id] = nil
  end

  def set_the_meta_tags(og_image=nil)
    set_meta_tags site: 'Open Source Citizen',
      description: 'An economic citizenship experiment aiming to increase economic participation in open source software.',
      keywords: %w[open source donate cryptocurrency crypto monero give hashes developers development economic citizenship software],
      icon: [
        { href: '/favicon-32x32.png', sizes: '32x32', type: 'image/png' },
        { href: '/favicon-32x32.png', rel: 'apple-touch-icon-precomposed', sizes: '32x32', type: 'image/png' }
      ],
      og: {
        title: :title,
        type: 'website',
        url: request.original_url,
        image: og_image || ActionController::Base.helpers.asset_path('mediakit/png/color_with_background@2x.png')
      },
      twitter: {
        card: 'summary',
        site: '@oscitizen',
        creator: '@oscitizen'
      }
  end
end
