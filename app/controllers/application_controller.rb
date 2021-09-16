class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    # User.find_by(google_token: session[:google_token]) if session[:google_token]
    session[:google_token]
  end
end
