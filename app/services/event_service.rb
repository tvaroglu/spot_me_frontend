class EventService < BackEndService
  def self.get_upcoming_events(user_id)
    response = db_conn.get("/api/v1/users/#{user_id}/events")
    parse_json(response)
  end

  def self.get_past_events(user_id)
    response = db_conn.get("/api/v1/users/#{user_id}/events?time_frame=past")
    parse_json(response)
  end

  def self.create_event(params)
    db_conn.post("/api/v1/users/#{params[:user_id]}/gym_memberships/#{params[:gym_membership_id]}/events") do |req|
      req.params['activity'] = params[:activity]
      req.params['date_time'] = params[:date_time]
    end
  end

  def self.delete_event(event_params)
    db_conn.delete(
      "/api/v1/users/#{event_params[:user_id]}/gym_memberships/#{event_params[:gym_membership_id]}/events/#{event_params[:id]}"
    )
  end
end
