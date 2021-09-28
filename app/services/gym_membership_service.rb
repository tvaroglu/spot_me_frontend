class GymMembershipService  < BackEndService
  def self.get_gym_memberships(user_id)
    response = db_conn.get("/api/v1/users/#{user_id}/gym_memberships")

    parse_json(response)
  end

  def self.create_gym_membership(gym_mem_params)
    db_conn.post(
      "/api/v1/users/#{gym_mem_params[:user_id]}/gym_memberships",
      gym_mem_params.to_json,
      'Content-Type' => 'application/json'
    )
  end

  def self.delete_gym_membership(gym_membership_params)
    db_conn.delete(
      "/api/v1/users/#{gym_membership_params[:user_id]}/gym_memberships/#{gym_membership_params[:id]}"
    )
  end
end
