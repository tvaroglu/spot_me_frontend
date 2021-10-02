class UsersController < ApplicationController
  def new; end

  def create
    UserFacade.create_user(params)
    found_user = UserFacade.get_user(params[:google_id])
    if found_user.present?
      session[:google_token] = params[:google_token]
      session[:google_id] = params[:google_id]
      redirect_to dashboard_index_path
    else
      flash[:error] = "Couldn't create your account, please try again."
      redirect_to root_path
    end
  end

  # User Profile
  def show
    current_user_friends = FriendshipFacade.get_friends(current_user.id)
    @profile_user = UserFacade.get_profile_user(params[:id])
    @user_friends = FriendshipFacade.get_friends(@profile_user.id)

    @user_type = if current_user.id.to_s == params[:id]
                   :self
                 elsif current_user_friends.any? do |friend|
                         friend.id.to_s == params[:id]
                       end
                   :friend
                 end

    return unless @user_type == :friend

    @user_events = EventFacade.get_upcoming_events(@profile_user.id)
  end

  def edit; end

  def update
    UserFacade.update_user(users_params, current_user.id)
    flash[:success] = 'Your profile has been updated!'
    redirect_to profile_path(current_user.id)
  end

  private

  def users_params
    params.permit(:full_name, :email, :zip_code, :summary, :goal,
                  :availability_morning, :availability_afternoon, :availability_evening)
  end
end
