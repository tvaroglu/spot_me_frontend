class BackEndService
  class << self

    def get_user(google_id)
      response = db_conn.get("/users/#{google_id}")
      require "pry"; binding.pry
      get_json(response)
    end

    def base_url
      'https://spotme-app-api.herokuapp.com/api/v1'
    end

    # def get_user(google_id)
    #   receive_request("/users/#{google_id}")
    # end

    def create_user(user_params)
      db_conn.post(
        "/users",
        user_params.to_json,
        'Content-Type' => 'application/json'
      )
    end

    # def receive_request(uri)
    #   conn = Faraday.new(url: base_url) do |faraday|
    #     # faraday.headers['Authorization'] = ENV['bearer']
    #   end.get(uri)
    #   JSON.parse(conn.body, symbolize_names: true)
    # end

    def send_request(uri, params)
      Faraday.new(url: base_url) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
      end.post("#{base_url}#{uri}", params.to_json)
    end

    def db_conn
      Faraday.new(base_url)
    end

    def get_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
