class Gym
  include Formatable
  attr_reader :yelp_gym_id,
              :name,
              :full_address,
              :address1,
              :address2,
              :address3,
              :city_state_zip,
              :phone,
              :gym_member_count

  def initialize(data)
    @yelp_gym_id      = data[:id]
    @name             = data[:attributes][:name]
    @full_address     = data[:attributes][:address]
    @address1         = data[:attributes][:address_details][:address1]
    @address2         = data[:attributes][:address_details][:address2]
    @address3         = data[:attributes][:address_details][:address3]
    @city_state_zip   = format_city_state_zip(data[:attributes][:address_details])
    @phone            = data[:attributes][:phone]
    @gym_member_count = data[:attributes][:gym_member_count]
  end
end
