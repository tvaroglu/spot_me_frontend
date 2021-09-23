class Gym
  attr_reader :yelp_gym_id, :name, :address, :phone

  def initialize(data)
    @yelp_gym_id = data[:id]
    @name        = data[:attributes][:name]
    @address     = data[:attributes][:address]
    @phone       = data[:attributes][:phone]
  end
end
