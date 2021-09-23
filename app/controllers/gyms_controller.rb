class GymsController < ApplicationController
  def index
    @gyms = BackEndFacade.get_gyms_near_user(params['zip_code'])
  end

  def show
    @gym = BackEndFacade.get_selected_gym(params[:id])
    @gym_users = BackEndFacade.get_gym_users(params[:id])
    @gym_users_count = BackEndFacade.get_gym_users_count(params[:id])
    @gym_friends = BackEndFacade.get_friends_at_gym(params[:id])
    @gym_non_friends = BackEndFacade.get_non_friends_at_gym(params[:id])
  end

  def create
    BackEndFacade.create_gym_membership(gym_membership_params)
    redirect_to dashboard_path(current_user.id)
  end

  def destroy
    BackEndFacade.delete_gym_membership(gym_membership_destroy_params)
    redirect_to dashboard_path(current_user.id)
    flash[:alert] = 'Gym removed... but you should probably join a new one ASAP if you want those gains!'
  end

  private

  def gym_membership_params
    params.permit(:user_id, :yelp_gym_id, :gym_name)
  end

  def gym_membership_destroy_params
    {
      user_id: params[:user_id],
      id: params[:id]
    }
  end
end
