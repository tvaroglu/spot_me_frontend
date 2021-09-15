class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find_by(google_token: session[:google_token]) if session[:google_token]
  end
end
