class GymsController < ApplicationController
  def index
    @gyms = BackEndFacade.get_gyms_near_user(params['zip_code'])
  end

  def show
    @gym = BackEndFacade.get_selected_gym(params[:id])
    @user_gym_membership = BackEndFacade.get_gym_membership(yelp_gym_id: params[:id], user_id: current_user.id)
    @gym_users_count = BackEndFacade.get_gym_users_count(params[:id])
    return unless @user_gym_membership.present?

    @gym_users = BackEndFacade.get_gym_users(params[:id])
    @gym_friends = BackEndFacade.get_friends_at_gym(params[:id], current_user.id)
    @gym_non_friends = BackEndFacade.get_non_friends_at_gym(yelp_gym_id: params[:id], user_id: current_user.id)
  end
end
