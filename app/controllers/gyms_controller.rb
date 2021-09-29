class GymsController < ApplicationController
  def index
    @gyms = GymFacade.get_gyms_near_user(params[:zip_code])
  end

  def show
    @gym = GymFacade.get_gym(params[:id])
    @user_gym_membership = GymMembershipFacade.get_gym_membership(
      yelp_gym_id: params[:id], user_id: current_user.id
    )
    @gym_users_count = GymFacade.get_gym_users_count(params[:id])
    return if @user_gym_membership.blank?

    @gym_users = GymFacade.get_gym_users(params[:id])
    @gym_friends = FriendshipFacade.get_friends_at_gym(params[:id],
                                                    current_user.id)
    @gym_non_friends = FriendshipFacade.get_non_friends_at_gym(
      yelp_gym_id: params[:id], user_id: current_user.id
    )
  end
end
