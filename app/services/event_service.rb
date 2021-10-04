class EventService < BackEndService
  def self.get_events(user_id, time_frame = nil)
    response = db_conn.get("/api/v1/users/#{user_id}/events") do |req|
      req.params['time_frame'] = time_frame if time_frame == 'past'
    end
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
