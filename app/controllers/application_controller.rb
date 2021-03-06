class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    UserFacade.get_user(session[:google_id]) if session[:google_id]
  end
end
