class SearchController < ApplicationController
  def index
    @gyms = BackEndFacade.get_gyms_near_user(params['format']) # figure out why it's params['format']
  end
end
