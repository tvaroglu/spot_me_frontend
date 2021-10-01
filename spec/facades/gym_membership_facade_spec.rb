require 'rails_helper'

describe GymMembershipFacade, type: :facade do
  describe '.get_gym_memberships' do
    context 'when the user has gyms' do
      it "can return an array of the user's gyms", :vcr do
        gyms = GymMembershipFacade.get_gym_memberships(1)

        expect(gyms[0]).to be_an_instance_of(GymMembership)
        expect(gyms).not_to be_empty
      end
    end

    context 'when the user does not have any gyms' do
      it 'can return an empty array', :vcr do
        gyms = GymMembershipFacade.get_gym_memberships(11)

        expect(gyms).to be_empty
      end
    end
  end

  describe '.create_gym_membership' do
    it 'returns a hash with the gym membership details' do
      user_id = 1
      yelp_gym_id = 'c2jzsndq8brvn9fbckeec2'
      gym_name = 'Planet Fitness'
      request_params = {
        'user_id': user_id,
        'yelp_gym_id': yelp_gym_id,
        'gym_name': gym_name
      }

      allow(GymMembershipService).to receive(:create_gym_membership).with(request_params).and_return(true)

      expect(GymMembershipFacade.create_gym_membership(request_params)).to eq(true)
    end
  end

  describe '.delete_gym_membership' do
    it 'returns a hash with the gym membership details' do
      user_id = 1
      gym_membership_id = 61
      path_params = {
        user_id: user_id,
        id: gym_membership_id
      }

      allow(GymMembershipService).to receive(:delete_gym_membership).with(path_params).and_return(true)

      expect(GymMembershipFacade.delete_gym_membership(path_params)).to eq(true)
    end
  end
end
