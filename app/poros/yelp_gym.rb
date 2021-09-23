class YelpGym
  attr_reader :yelp_gym_id, :name, :address, :phone

  def initialize(data)
    @yelp_gym_id = data[:id]
    return unless data[:attributes]

    @name = data[:attributes][:name]
    @address = data[:attributes][:address]
    @phone = data[:attributes][:phone]
  end
end
