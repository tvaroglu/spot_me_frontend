require 'rails_helper'

describe GymMembership, type: :poro do
  let!(:gym_membership_id) { '1' }
  let!(:yelp_gym_id) { 'lex65fkcol5gfq89rymmd2' }
  let!(:gym_name) { 'Planet Fitness' }
  let(:gym_membership_params) do
    {
      id: gym_membership_id,
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: yelp_gym_id,
        gym_name: gym_name
      },
      meta: {
        address: '123 Main St',
        address_details: {
          address1: '123 Main St',
          address2: '',
          address3: '',
          city: 'Somewhere',
          state: 'USA',
          zip_code: '12345'
        }
      }
    }
  end
  let(:gym_membership) { GymMembership.new(gym_membership_params) }

  describe 'object creation' do
    it 'initializes from given parameters' do
      expect(gym_membership).to be_an_instance_of(GymMembership)

      expect(gym_membership.yelp_gym_id).to eq yelp_gym_id
      expect(gym_membership.yelp_gym_id).to be_a String

      expect(gym_membership.gym_name).to eq gym_name
      expect(gym_membership.gym_name).to be_a String

      expect(gym_membership.id).to eq gym_membership_id
      expect(gym_membership.id).to be_a String

      expect(gym_membership.address).to eq '123 Main St'
      expect(gym_membership.address).to be_a String

      expect(gym_membership.address_details).to be_a Hash
      expect(gym_membership.address_details).to eq gym_membership_params[:meta][:address_details]

      expect(gym_membership.address1).to eq '123 Main St'
      expect(gym_membership.address1).to be_a String
      expect(gym_membership.address2).to eq ''
      expect(gym_membership.address2).to be_a String
      expect(gym_membership.address3).to eq ''
      expect(gym_membership.address3).to be_a String
    end
  end

  describe 'instance methods' do
    describe '#city_state_zip' do
      it 'returns the concatenated city, state, and zip' do
        address_details = gym_membership_params[:meta][:address_details]

        expect(gym_membership.format_city_state_zip(address_details)).to eq('Somewhere, USA 12345')
      end
    end
  end
end
