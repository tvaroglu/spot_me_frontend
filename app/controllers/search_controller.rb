class SearchController < ApplicationController
  def index
    @gyms = BackEndFacade.get_gyms_near_user(params['zip_code'])
  end
end
