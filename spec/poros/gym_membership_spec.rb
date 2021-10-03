require 'rails_helper'

describe GymMembership, type: :poro do
  describe 'object creation' do
    it 'initialize from given parameters params' do
      gym_membership_id = '1'
      yelp_gym_id = 'lex65fkcol5gfq89rymmd2'
      gym_name = 'Planet Fitness'

      gym_membership_params = {
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

      gym_membership = GymMembership.new(gym_membership_params)

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
    end
  end
end
