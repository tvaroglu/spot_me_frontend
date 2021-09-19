class BackEndService
  class << self

    def get_user(google_id)
      response = db_conn.get("/users/#{google_id}")
      get_json(response)
    end

    def get_friends(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/friendships")
      get_json(response)
    end

    def get_gyms(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/gyms")
      get_json(response)
    end

    def create_user(user_params)
      db_conn.post(
        "/users",
        user_params.to_json,
        'Content-Type' => 'application/json'
      )
    end

    # def gyms_near_user(location)
    #   response = yelp_connection.get("v3/businesses/search?term=gyms&radius=40000&sort_by=distance&location=#{location}")
    #   get_json(response)
    # end

    def get_events(user_id)
      response = db_conn.get("/api/v1/users/#{user_id}/events")
      get_json(response)
    end

    # def send_request(uri, params)
    #   Faraday.new(url: base_url) do |faraday|
    #     faraday.headers['Content-Type'] = 'application/json'
    #   end.post("#{base_url}#{uri}", params.to_json)
    # end

    def base_url
      'https://spotme-app-api.herokuapp.com'
    end

    def db_conn
      Faraday.new(base_url)
    end

    def yelp_connection
      Faraday.new(url: 'https://api.yelp.com/') do |faraday|
        faraday.headers['Authorization'] = ENV['yelp_api_key']
      end
    end

    def get_json(response)
      response.instance_of?(String) ? JSON.parse(response, symbolize_names: true) : JSON.parse(response.body, symbolize_names: true)
    end
  end
end
