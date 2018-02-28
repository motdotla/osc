class AuthController < ApplicationController
  def callback
    user = FindOrCreateUser.new(omniauth_response: omniauth_response).run

    SetSession.new(user: user, session: session).run
    SetCookies.new(user: user, cookies: cookies).run

    redirect_to '/dashboard/loading' # Start at loading - in order to update project data
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']

    render json: { msg: "#{@error_msg}. Sorry about that! Please contact us at opensourcecitizen@protonmail.com to get you all signed up." }
  end

  def omniauth_response
    request.env['omniauth.auth']
  end
end
