class BackEndService
  def self.db_conn
    Faraday.new('https://spotme-app-api.herokuapp.com')
    # Faraday.new('http://localhost:4500')
  end

  def self.parse_json(response)
    # TODO: debug API; receiving 500's on certain gym membership add/removes..?
      # i.e. NoMethodError (undefined method `address' for #<Hash:0x000055cc15d77508>):
    return {} if response.body.nil? || response.body.strip.empty?
    # puts "STATUS: #{response.status}"
    # puts "BODY: #{response.body.inspect}"
    JSON.parse(response.body, symbolize_names: true)
  end
end
