class DashboardController < ApplicationController
  def index
    # @user_friends = FriendshipFacade.get_friends(current_user.id)
    # @user_followers = FriendshipFacade.get_followers(current_user.id)
    # @user_gyms = GymMembershipFacade.get_gym_memberships(current_user.id)
    # @user_events = EventFacade.get_events(current_user.id)
    # @past_events = EventFacade.get_events(current_user.id, 'past')
    @user_friends = (current_user && current_user.id) ? FriendshipFacade.get_friends(current_user.id) : []
    @user_followers = (current_user && current_user.id) ? FriendshipFacade.get_followers(current_user.id) : []
    @user_gyms = (current_user && current_user.id) ? GymMembershipFacade.get_gym_memberships(current_user.id) : []
    @user_events = (current_user && current_user.id) ? EventFacade.get_events(current_user.id) : []
    @past_events = (current_user && current_user.id) ? EventFacade.get_events(current_user.id, 'past') : []
  end
end
