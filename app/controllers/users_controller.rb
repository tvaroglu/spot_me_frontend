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
    @profile_user = BackEndFacade.get_profile_user(params[:user_id])
    @user_friends = BackEndFacade.get_user_friends(@profile_user.id)

    @user_type = if current_user.id.to_s == params[:user_id]
                      :self
                    elsif current_user_friends.any? do |friend|
                            friend.id.to_s == params[:user_id]
                          end
                      :friend
                    end
  end

  def edit; end

  def update
    BackEndFacade.update_user(users_params, current_user.id)
    flash[:success] = 'Your profile has been updated!'
    redirect_to profile_path(current_user.id)
  end

  private

  def users_params
    params.permit(:full_name, :email, :zip_code, :summary, :goal, :availability_morning, :availability_afternoon, :availability_evening)
  end
end
