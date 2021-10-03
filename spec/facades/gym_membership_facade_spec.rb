require 'rails_helper'

describe GymMembershipFacade, type: :facade do
  describe '.get_gym_memberships' do
    context 'when the user has gyms' do
      it "can return an array of the user's gyms", :vcr do
        # NOTE: if you are doing local dev work and have to rerecord cassettes against LocalHost
        # make sure your User with user_id == 1 has their GymMemberships updated with the following:
        # yelp_gym_id: 'gHmS3WIjRRhSWG4OdCQYLA'

        # New meta keys from GymMembership query Yelp for address info, and require a real yelp_gym_id
        # Heroku DB has been updated accordingly, but local DB requires this update if rerecording cassettes
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
