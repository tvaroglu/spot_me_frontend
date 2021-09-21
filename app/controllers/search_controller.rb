class SearchController < ApplicationController
  def index
    @gyms = BackEndFacade.get_gyms_near_user(params['zip_code'])
  end

  def show
    @gym = BackEndFacade.get_selected_gym(params[:id])
  end
end
