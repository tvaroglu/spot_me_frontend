class SearchController < ApplicationController
  def index
    @gyms = BackEndFacade.get_gyms_near_user(params['zip_code'])
  end

  def show
    @gym = BackEndFacade.get_selected_gym(params[:id])
  end

  def create
    BackEndFacade.create_gym_membership(gym_membership_params)
    redirect_to dashboard_path(current_user.id)
  end

  private

  def gym_membership_params
    params.permit(:user_id, :yelp_gym_id, :gym_name)
  end
end
