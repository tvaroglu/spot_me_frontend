require 'rails_helper'

describe Gym, type: :poro do
  describe 'object creation' do
    it 'initialize from given parameters params' do
      yelp_gym_id = '1'
      name = 'Planet Fitness'
      full_address = '123 Main St'
      phone = '123-123-1234'
      address1 = "430 Pierre St"
      address2 = nil
      address3 = ''
      city = 'Boulder'
      state = 'CO'
      zip_code = '80304'
      city_state_zip = 'Boulder, CO 80304'

      gym_params = {
        id: yelp_gym_id,
        type: 'gym',
        attributes: {
          name: name,
          address: full_address,
          phone: phone,
          address_details: {
            address1: address1,
            address2: address2,
            address3: address3,
            city: city,
            state: state,
            zip_code: zip_code
          }
        }
      }

      gym = Gym.new(gym_params)

      expect(gym).to be_an_instance_of(Gym)
      expect(gym.yelp_gym_id).to eq(yelp_gym_id)
      expect(gym.yelp_gym_id).to be_a String
      expect(gym.name).to eq(name)
      expect(gym.name).to be_a String
      expect(gym.full_address).to eq(full_address)
      expect(gym.full_address).to be_a String
      expect(gym.address1).to eq(address1)
      expect(gym.address1).to be_a String
      expect(gym.address2).to eq(address2)
      expect(gym.address3).to eq(address3)
      expect(gym.city_state_zip).to eq(city_state_zip)
      expect(gym.city_state_zip).to be_a String
      expect(gym.phone).to eq(phone)
      expect(gym.phone).to be_a String
    end
  end

  describe 'instance methods' do
    describe '#city_state_zip' do
      it 'returns the concatenated city, state, and zip' do
        yelp_gym_id = '1'
        name = 'Planet Fitness'
        full_address = '123 Main St'
        phone = '123-123-1234'
        city = 'Boulder'
        state = 'CO'
        zip_code = '80304'

        gym_params = {
          id: yelp_gym_id,
          type: 'gym',
          attributes: {
            name: name,
            address: full_address,
            phone: phone,
            address_details: {
              city: city,
              state: state,
              zip_code: zip_code
            }
          }
        }

        gym = Gym.new(gym_params)

        expect(gym.format_city_state_zip(gym_params)).to eq('Boulder, CO 80304')
      end
    end
  end
end
