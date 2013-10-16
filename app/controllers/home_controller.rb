class HomeController < ApplicationController
  helper_method :signed_in?

  def index
    @user_login = if signed_in?
                    current_user.login
                  end
  end

  def signed_in?
    !current_user.nil?
  end
end
