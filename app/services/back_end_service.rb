class BackEndService
  def self.db_conn
    # Faraday.new('https://spotme-app-api.herokuapp.com')
    Faraday.new('http://localhost:4500')
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
