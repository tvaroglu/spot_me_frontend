class UsersController < ApplicationController
  def new; end

  def create
    # require "pry"; binding.pry
    BackEndFacade.create_user(params)
    found_user = BackEndFacade.get_user(params[:google_id])
    if found_user.id.present?
      session[:google_token] = found_user.google_token
      redirect_to dashboard_path(found_user.id)
    else
      flash[:error] = "Couldn't create your account, please try again."
      redirect_to root_path
    end
  end
end
