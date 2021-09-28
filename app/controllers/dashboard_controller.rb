class DashboardController < ApplicationController
  def index
    @user_friends = BackEndFacade.get_user_friends(current_user.id)
    @user_gyms = BackEndFacade.get_user_gyms(current_user.id)
    @user_events = BackEndFacade.get_user_events(current_user.id)
  end
end
