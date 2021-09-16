class UsersController < ApplicationController
  def new; end

  def create
    # require "pry"; binding.pry
    BackEndFacade.create_user(params)
    found_user = BackEndFacade.get_user(params[:google_id])
    if found_user.present?
    # if params[:google_token]
      session[:google_token] = params[:google_token]
      redirect_to dashboard_path(found_user.id)
      # redirect_to dashboard_path(params[:google_id])
    else
      flash[:error] = "Couldn't create your account, please try again."
      redirect_to root_path
    end
  end

  def dashboard; end
end
