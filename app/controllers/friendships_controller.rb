class FriendshipsController < ApplicationController
  def create
    FriendshipFacade.add_friend(create_friendship_params)
    flash[:alert] = "You just added a SwoleMate! Now go get them gains!!"
    redirect_to URI(request.referer).path
  end

  def destroy
    FriendshipFacade.delete_friend(destroy_friendship_params)
    redirect_to URI(request.referer).path
    flash[:alert] = 'SwoleMate removed!'
  end

  private

  def create_friendship_params
    {
      user_id: params[:user_id],
      followee_id: params[:followee_id]
    }
  end

  def destroy_friendship_params
    {
      user_id: params[:user_id],
      id: params[:followee_id]
    }
  end
end
