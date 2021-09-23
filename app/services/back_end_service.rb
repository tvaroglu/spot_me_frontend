class BackEndService
  class << self
    def get_user(google_id)
      response = db_conn.get("/api/v1/users/find?google_id=#{google_id}")
      parse_json(response.body)
    end

    def get_friends(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/friendships")
      parse_json(response.body)
    end

    def get_events(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/events")
      parse_json(response.body)
    end

    def get_gyms(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/gym_memberships")
      parse_json(response.body)
    end

    def create_user(user_params)
      db_conn.post(
        '/api/v1/users',
        user_params.to_json,
        'Content-Type' => 'application/json'
      )
    end

    def delete_event(event_params)
      db_conn.delete(
        "/api/v1/users/#{event_params[:user_id]}/gym_memberships/#{event_params[:gym_membership_id]}/events/#{event_params[:id]}"
      )
    end

    def delete_gym_membership(gym_membership_params)
      db_conn.delete(
        "/api/v1/users/#{gym_membership_params[:user_id]}/gym_memberships/#{gym_membership_params[:id]}"
      )
    end

    def gyms_near_user(zip_code)
      response = db_conn.get("/api/v1/gym_search?zip_code=#{zip_code}")

      parse_json(response.body)
    end

    def get_one_gym(yelp_gym_id)
      response = db_conn.get("/api/v1/gym_search/#{yelp_gym_id}")
      parse_json(response.body)
    end

    def post_gym_membership(gym_mem_params)
      db_conn.post("/api/v1/users/#{gym_mem_params[:user_id]}/gym_memberships",
        gym_mem_params.to_json,'Content-Type' => 'application/json')
    end

    def get_gym_users(yelp_gym_id)
      response = db_conn.get("api/v1/gym_memberships/users") do |req|
        req.params['yelp_gym_id'] = yelp_gym_id
      end
      parse_json(response.body)
    end

    def get_friends_at_gym(yelp_gym_id)
      response = db_conn.get("api/v1/gym_memberships") do |req|
        req.params['yelp_gym_id'] = yelp_gym_id
      end
      parse_json(response.body)
    end

    def get_non_friends_at_gym(yelp_gym_id)
      esponse = db_conn.get("api/v1/gym_memberships") do |req|
        req.params['yelp_gym_id'] = yelp_gym_id
      end
      parse_json(response.body)
    end

    def base_url
      # NOTE: base_url needs to be localhost if you want to auth in during development
      # Open your BE server via $ rails s --port 4500
      'http://localhost:4500'
      # 'https://spotme-app-api.herokuapp.com'
    end

    def db_conn
      Faraday.new(base_url)
    end

    def parse_json(response_body)
      JSON.parse(response_body, symbolize_names: true)
    end
  end
end
