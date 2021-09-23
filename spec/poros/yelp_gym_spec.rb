require 'rails_helper'

RSpec.describe YelpGym, type: :poro do
  describe 'object creation' do
    it 'initialize from given parameters params' do
      yelp_gym_id = '1'
      name = 'Planet Fitness'
      address = '123 Main St'
      phone = '123-123-1234'

      gym_params = {
        id: yelp_gym_id,
        type: 'gym',
        attributes: {
          name: name,
          address: address,
          phone: phone
        }
      }

      gym = YelpGym.new(gym_params)

      expect(gym).to be_an_instance_of(YelpGym)
      expect(gym.yelp_gym_id).to eq(yelp_gym_id)
      expect(gym.yelp_gym_id).to be_a String
      expect(gym.name).to eq(name)
      expect(gym.name).to be_a String
      expect(gym.address).to eq(address)
      expect(gym.address).to be_a String
      expect(gym.phone).to eq(phone)
      expect(gym.phone).to be_a String
    end
  end
end
