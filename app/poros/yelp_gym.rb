class YelpGym
  attr_reader :yelp_gym_id, :name, :address, :phone

  def initialize(info)
    @yelp_gym_id = info[:id]
    @name = info[:name]
    @address = info[:address]
    @phone = info[:phone]
  end
end
