require 'rails_helper'

describe Gym, type: :poro do
  let!(:yelp_gym_id) { '1' }
  let!(:name) { 'Planet Fitness' }
  let!(:full_address) { '430 Pierre St' }
  let!(:phone) { '123-123-1234' }
  let!(:address1) { '430 Pierre St' }
  let!(:address2) { '' }
  let!(:address3) { '' }
  let!(:city) { 'Boulder' }
  let!(:state) { 'CO' }
  let!(:zip_code) { '80304' }
  let!(:city_state_zip) { 'Boulder, CO 80304' }
  let!(:gym_params) do
    {
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
        },
        gym_member_count: 0
      }
    }
  end
  let(:gym) { Gym.new(gym_params) }

  describe 'object creation' do
    it 'initializes from given parameters' do
      expect(gym).to be_an_instance_of(Gym)

      expect(gym.yelp_gym_id).to eq yelp_gym_id
      expect(gym.yelp_gym_id).to be_a String

      expect(gym.name).to eq name
      expect(gym.name).to be_a String

      expect(gym.full_address).to eq full_address
      expect(gym.full_address).to be_a String

      expect(gym.address1).to eq address1
      expect(gym.address1).to be_a String
      expect(gym.address2).to eq address2
      expect(gym.address2).to be_a String
      expect(gym.address3).to eq address3
      expect(gym.address3).to be_a String

      expect(gym.city_state_zip).to eq(city_state_zip)
      expect(gym.city_state_zip).to be_a String

      expect(gym.phone).to eq(phone)
      expect(gym.phone).to be_a String

      expect(gym.gym_member_count).to eq 0
      expect(gym.gym_member_count).to be_an Integer
    end
  end

  describe 'instance methods' do
    describe '#city_state_zip' do
      it 'returns the concatenated city, state, and zip' do
        address_details = gym_params[:attributes][:address_details]

        expect(gym.format_city_state_zip(address_details)).to eq(city_state_zip)
      end
    end
  end
end
