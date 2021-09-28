require 'rails_helper'

describe GymMembershipService, type: :service do
  it 'can create a gym membership', :vcr do
    json_response = File.read('./spec/fixtures/gym_membership.json')

    allow(GymMembershipService).to receive(:create_gym_membership).and_return(JSON.parse(json_response, symbolize_names: true))

    expect(GymMembershipService.create_gym_membership(json_response).class).to eq(Hash)
  end
end
