class GymMembershipsController < ApplicationController
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
