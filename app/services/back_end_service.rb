class BackEndService
  class << self
    def get_user(google_id)
      response = db_conn.get("/users/#{google_id}")
      parse_json(response.body)
    end

    def get_friends(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/friendships")
      parse_json(response.body)
    end

    def get_gyms(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/gyms")
      parse_json(response.body)
    end

    def get_events(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/events")
      parse_json(response.body)
    end

    # TODO:  understand why we need this method?  BE is calling the API for us
    # def gyms_near_user(location)
    #   response = yelp_connection.get("v3/businesses/search?term=gyms&radius=40000&sort_by=distance&location=#{location}")
    #   parse_json(response.body)
    # end

    def create_user(user_params)
      db_conn.post(
        "/users",
        user_params.to_json,
        'Content-Type' => 'application/json'
      )
    end

    def base_url
      'https://spotme-app-api.herokuapp.com'
    end

    def db_conn
      Faraday.new(base_url)
    end

    def parse_json(response_body)
      JSON.parse(response_body, symbolize_names: true)
    end

    # TODO:  understand why we need this method?  BE is calling the API for us
    def yelp_connection
      Faraday.new(url: 'https://api.yelp.com/') do |faraday|
        faraday.headers['Authorization'] = ENV['yelp_api_key']
      end
    end
  end
end
