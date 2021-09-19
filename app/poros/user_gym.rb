class UserGym
  attr_reader :yelp_gym_id

  def initialize(info)
    @yelp_gym_id = info[:attributes][:yelp_gym_id]
    # @name = info[:attributes][:name]
    @id = info[:id]
  end
end
