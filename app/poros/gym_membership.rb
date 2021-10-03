class GymMembership
  attr_reader :id, :gym_name, :yelp_gym_id, :address, :address_details

  def initialize(data)
    @id              = data[:id]
    @gym_name        = data[:attributes][:gym_name]
    @yelp_gym_id     = data[:attributes][:yelp_gym_id]
    @address         = data[:meta][:address]
    @address_details = data[:meta][:address_details]
  end
end
