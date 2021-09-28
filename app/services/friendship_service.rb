class FriendshipService < BackEndService
  def self.get_friends(user_id)
    response = db_conn.get("/api/v1/users/#{user_id}/friendships")
    parse_json(response)
  end

  def self.get_friends_at_gym(yelp_gym_id, current_user_id)
    response = db_conn.get("api/v1/users/#{current_user_id}/friendships") do |req|
      req.params['yelp_gym_id'] = yelp_gym_id
    end
    parse_json(response)
  end

  def self.get_non_friends_at_gym(params)
    response = db_conn.get("api/v1/users/#{params[:user_id]}/gym_members") do |req|
      req.params['yelp_gym_id'] = params[:yelp_gym_id]
    end
    parse_json(response)
  end

  def self.add_friend(friendship_params)
    response = db_conn.post("/api/v1/users/#{friendship_params[:user_id]}/friendships") do |req|
      req.params['followee_id'] = friendship_params[:followee_id]
    end
    parse_json(response)
  end

  def self.delete_friend(friend_params)
    db_conn.delete(
      "/api/v1/users/#{friend_params[:user_id]}/friendships/#{friend_params[:id]}"
    )
  end
end
