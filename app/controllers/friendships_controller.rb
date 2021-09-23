class FriendshipsController < ApplicationController
  def create
    BackEndFacade.add_friend(params[:user_id], params[:followee_id])
  end
end
