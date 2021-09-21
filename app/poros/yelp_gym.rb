class YelpGym
  attr_reader :yelp_gym_id, :name, :address, :phone

  def initialize(info)
    @yelp_gym_id = info[:id]
    @name = info[:attributes][:name]
    @address = info[:attributes][:address]
    @phone = info[:attributes][:phone]
  end
end
