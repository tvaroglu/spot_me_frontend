class FriendshipsController < ApplicationController
  def create
    BackEndFacade.add_friend(create_friendship_params)
    flash[:alert] = "You've just added a Swolemate! Now go get them gains!!"
    redirect_to dashboard_index_path
  end

  def destroy
    BackEndFacade.delete_friend(destroy_friendship_params)
    redirect_to dashboard_index_path
    flash[:alert] = 'Swolemate removed!'
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
