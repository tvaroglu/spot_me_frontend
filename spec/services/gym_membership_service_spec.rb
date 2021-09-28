require 'rails_helper'

describe GymMembershipService, :vcr, type: :service do
  describe 'class methods' do
    describe '.create_gym_membership' do
      it 'returns a hash with the new gym membership details' do
        json_response = File.read('./spec/fixtures/gym_membership.json')

        allow(GymMembershipService).to receive(:create_gym_membership).and_return(JSON.parse(json_response, symbolize_names: true))

        expect(GymMembershipService.create_gym_membership(json_response).class).to eq(Hash)
      end
    end
  end
end
