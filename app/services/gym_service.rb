class GymService < BackEndService
  def self.get_gyms_near_user(zip_code)
    response = db_conn.get("/api/v1/gym_search?zip_code=#{zip_code}")
    parse_json(response)
  end

  def self.get_gym(yelp_gym_id)
    response = db_conn.get("/api/v1/gym_search/#{yelp_gym_id}")
    parse_json(response)
  end

  def self.get_gym_users(yelp_gym_id)
    response = db_conn.get('api/v1/gym_memberships/users') do |req|
      req.params['yelp_gym_id'] = yelp_gym_id
    end
    parse_json(response)
  end
end
