class UserGym
  attr_reader :name, :yelp_gym_id

  def initialize(info)
    @yelp_gym_id = info[:id]
    @name = info[:name]
  end
end
