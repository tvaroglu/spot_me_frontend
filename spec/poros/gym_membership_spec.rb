require 'rails_helper'

RSpec.describe GymMembership, type: :poro do
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
        }
      }

      gym_membership = GymMembership.new(gym_membership_params)

      expect(gym_membership).to be_an_instance_of(GymMembership)
      expect(gym_membership.yelp_gym_id).to eq(yelp_gym_id)
      expect(gym_membership.yelp_gym_id).to be_a String
      expect(gym_membership.gym_name).to eq(gym_name)
      expect(gym_membership.gym_name).to be_a String
      expect(gym_membership.id).to eq(gym_membership_id)
      expect(gym_membership.id).to be_a String
    end
  end
end
