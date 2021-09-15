class BackEndService
  class << self
    def hello
      'world'
    end

    def receive_request(endpoint)
      conn = Faraday.new(url: endpoint) do |faraday|
        # faraday.headers['Authorization'] = ENV['bearer']
      end.get(endpoint)
      JSON.parse(conn.body)
    end

    def send_request(endpoint, params)
      Faraday.post(endpoint) do |faraday|
        # faraday.headers['Authorization'] = ENV['bearer']
        faraday.headers['Content-Type'] = 'application/json'
        faraday.body = params.to_json
      end
    end
  end
end
