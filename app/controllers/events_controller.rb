class EventsController < ApplicationController
  def create; end

  def destroy
    BackEndFacade.delete_event(event_destroy_params)
    redirect_to dashboard_path(current_user.id)
    flash[:alert] = 'Workout deleted... but you should schedule a new one ASAP if you want those gains!'
  end

  private

  def event_destroy_params
    {
      user_id: params[:user_id],
      gym_membership_id: params[:gym_membership_id],
      id: params[:id]
    }
  end
end
