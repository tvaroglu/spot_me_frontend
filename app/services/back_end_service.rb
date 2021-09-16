class BackEndService
  class << self
    def base_url
      'http://localhost:3000/api/v1'
      # 'https://spotme-app-api.herokuapp.com/api/v1'
    end

    def get_user(google_id)
      receive_request("/users/#{google_id}")
    end

    def create_user(user_params)
      send_request('/users', user_params)
    end

    def receive_request(uri)
      conn = Faraday.new(url: base_url) do |faraday|
        # faraday.headers['Authorization'] = ENV['bearer']
      end.get(uri)
      JSON.parse(conn.body, symbolize_names: true)
    end

    def send_request(uri, params)
      Faraday.new(url: base_url) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
      end.post("#{base_url}#{uri}", params.to_json)
    end
  end
end
