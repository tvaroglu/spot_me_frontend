class GymMembershipsController < ApplicationController
  def create
    GymMembershipFacade.create_gym_membership(gym_membership_params)
    redirect_to dashboard_index_path
  end

  def destroy
    GymMembershipFacade.delete_gym_membership(gym_membership_destroy_params)
    redirect_to dashboard_index_path
    flash[:alert] =
      'Gym removed... but you should probably join a new one ASAP if you want those gains!'
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
