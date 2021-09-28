class UserService  < BackEndService
  def self.get_user(google_id)
    response = db_conn.get("/api/v1/users/find?google_id=#{google_id}")
    parse_json(response)
  end

  def self.get_profile_user(user_id)
    response = db_conn.get("/api/v1/users/#{user_id}")
    parse_json(response)
  end

  def self.create_user(user_params)
    db_conn.post(
      '/api/v1/users',
      user_params.to_json,
      'Content-Type' => 'application/json'
    )
  end

  def self.update_user(user_params, user_id)
    db_conn.patch(
      "/api/v1/users/#{user_id}",
      user_params.to_json,
      'Content-Type' => 'application/json'
    )
  end
end
