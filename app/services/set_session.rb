class SetSession
  def initialize(user:, session:)
    @user = user
    @session = session
  end

  def run
    @session[:user_id] = @user.id
  end
end
