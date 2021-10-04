class DashboardController < ApplicationController
  def index
    @user_friends = FriendshipFacade.get_friends(current_user.id)
    @user_followers = FriendshipFacade.get_followers(current_user.id)
    @user_gyms = GymMembershipFacade.get_gym_memberships(current_user.id)
    @user_events = EventFacade.get_upcoming_events(current_user.id)
    @past_events = EventFacade.get_past_events(current_user.id)
  end
end
