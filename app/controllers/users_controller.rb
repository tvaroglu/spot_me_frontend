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

  def profile
    current_user_friends = BackEndFacade.get_user_friends(current_user.id)
    @user = BackEndFacade.get_user(params[:user_id])
    @user_friends = BackEndFacade.get_user_friends(@user.id)
    @user_gyms = BackEndFacade.get_user_gyms(@user.id)
    @user_events = BackEndFacade.get_user_events(@user.id)

    @user_profile = if current_user.id.to_s == params[:user_id]
                      :self
                    elsif current_user_friends.any? do |friend|
                            friend.id.to_s == params[:user_id]
                          end
                      :friend
                    end
  end

  def update
    # TODO: write this method and create view
    # BackEndFacade.update_user(params)
  end
end
