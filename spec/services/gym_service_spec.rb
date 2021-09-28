require 'rails_helper'

describe GymService, type: :service do
  it 'can parse searched gyms json', :vcr do
    expect(GymService.get_gyms_near_user('80227').class).to eq(Hash)
  end

  it 'can parse one gym json', :vcr do
    result = GymService.get_gym('BJBXzKYxQAXZKb5W6HrRnA')
    expect(result.class).to eq(Hash)
  end

  it "can parse a gym's users", :vcr do
    expect(GymService.get_gym_users('BJBXzKYxQAXZKb5W6HrRnA')).to be_a(Hash)
  end
end
