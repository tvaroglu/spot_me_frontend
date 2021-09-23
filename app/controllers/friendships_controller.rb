class FriendshipsController < ApplicationController
  def create
    BackEndFacade.add_friend(friendship_params)
    flash[:alert] = "You've just added a Swolemate! Now go get them gains!!"
    redirect_to dashboard_path(current_user.id)
  end

  private

  def friendship_params
    {
      user_id: params[:user_id],
      followee_id: params[:followee_id],
    }
  end
end
