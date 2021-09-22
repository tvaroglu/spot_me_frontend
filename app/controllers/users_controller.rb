class UsersController < ApplicationController
  def new; end

  def create
    BackEndFacade.create_user(params)
    found_user = BackEndFacade.get_user(params[:google_id])
    if found_user.present?
      session[:google_token] = params[:google_token]
      session[:google_id] = params[:google_id]
      redirect_to dashboard_path(found_user.id)
    else
      flash[:error] = "Couldn't create your account, please try again."
      redirect_to root_path
    end
  end

  def dashboard
    @user_friends = BackEndFacade.get_user_friends(current_user.id)
    @user_gyms = BackEndFacade.get_user_gyms(current_user.id)
    @user_events = BackEndFacade.get_user_events(current_user.id)
  end

  def profile; end

  def edit;  end
  
  def update
    # TODO: write this method and create view
    # BackEndFacade.update_user(params)
  end
end
