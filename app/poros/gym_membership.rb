class GymMembership
  include Convertable
  attr_reader :id,
              :gym_name,
              :yelp_gym_id,
              :address,
              :address_details,
              :address1,
              :address2,
              :address3
              # :city_state_zip

  def initialize(data)
    @id              = data[:id]
    @gym_name        = data[:attributes][:gym_name]
    @yelp_gym_id     = data[:attributes][:yelp_gym_id]
    @address         = data[:meta][:address]
    @address_details = data[:meta][:address_details]
    @address1        = @address_details[:address1]
    @address2        = @address_details[:address2]
    @address3        = @address_details[:address3]
    # @city_state_zip  = format_city_state_zip(data)
  end
end
