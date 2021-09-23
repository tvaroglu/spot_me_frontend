class EventsController < ApplicationController
  def new
    @friend_id         = params[:friend_id]
    @friend_name       = params[:friend_name]
    @gym_membership_id = params[:gym_membership_id]
    @gym_name          = params[:gym_name]
  end

  def create
    new_event = BackEndFacade.create_event(create_event_params)
    if new_event.present?
      flash[:alert] = 'Workout created! Now go get your swell on!'
      redirect_to dashboard_path(current_user.id)
    else
      flash[:alert] = 'Error: Something went wrong!'
      redirect_to URI(request.referer).path
    end
  end

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

  def new_event_params
    params.permit(:friend_id, :friend_name, :gym_membership_id, :gym_name)
  end

  def create_event_params
    params[:date_time] = DateTime.civil(
      params[:date]['when(1i)'].to_i,
      params[:date]['when(2i)'].to_i,
      params[:date]['when(3i)'].to_i,
      params[:time]['start_time(4i)'].to_i,
      params[:time]['start_time(5i)'].to_i
    )

    params.permit(:user_id, :gym_membership_id, :activity, :date_time)
  end
end
