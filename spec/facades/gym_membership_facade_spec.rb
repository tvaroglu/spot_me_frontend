require 'rails_helper'

describe GymMembershipFacade, type: :facade do
  describe '.get_gym_memberships' do
    it "can return an array of the user's gyms if present", :vcr do
      gyms = GymMembershipFacade.get_gym_memberships(1)

      expect(gyms).to be_an(Array)
      if gyms.size > 0
        expect(gyms[0]).to be_an_instance_of(GymMembership)
      else
        expect(gyms).to be_empty
      end
    end

    it 'can return an empty array if no gyms present', :vcr do
      gyms = GymMembershipFacade.get_gym_memberships(0)

      expect(gyms).to be_empty
    end
  end

  describe '.create_gym_membership' do
    it 'returns a hash with the gym membership details' do
      user_id = 1
      yelp_gym_id = 'gHmS3WIjRRhSWG4OdCQYLA'
      gym_name = 'Planet Fitness'
      request_params = {
        user_id: user_id,
        yelp_gym_id: yelp_gym_id,
        gym_name: gym_name
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
