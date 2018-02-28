class SetCookies
  def initialize(user:, cookies:)
    @user = user
    @cookies = cookies
  end

  def run
    @cookies.permanent[:citizen_id] = @user.id
  end
end
