class UserBuilder
  def from_omniauth(auth)
    find_user(auth) || create_user(auth)
  end

  private

  def find_user(auth)
    User.where(auth.slice("provider", "uid")).first
  end

  def create_user(auth)
    User.create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.login = auth["extra"]["raw_info"]["login"]
      user.email = auth["info"]["email"]
    end
  end
end
