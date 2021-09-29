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
end
