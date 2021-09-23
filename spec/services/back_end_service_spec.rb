require 'rails_helper'

RSpec.describe BackEndService do
  xit 'can retrieve the base url for API calls' do
    expect(BackEndService.base_url).to eq 'https://spotme-app-api.herokuapp.com'
  end

  it 'can parse json' do
    json_blob = File.read('./spec/fixtures/user.json')

    expect(BackEndService.parse_json(json_blob).class).to eq(Hash)
  end

  it 'can send a json body' do
    json_response = File.read('./spec/fixtures/user.json')
    allow(BackEndService).to receive(:create_user).and_return(JSON.parse(json_response, symbolize_names: true))

    expect(BackEndService.create_user(json_response).class).to eq(Hash)
  end

  it 'can receive a request', :vcr do
    json_response = File.read('./spec/fixtures/user.json')
    allow(BackEndService).to receive(:parse_json)
      .and_return(JSON.parse(json_response, symbolize_names: true))

    expect(BackEndService.get_user(789).class).to eq(Hash)
  end

  it 'can parse friendships json', :vcr do
    expect(BackEndService.get_friends(1).class).to eq(Hash)
  end

  it 'can parse gyms json', :vcr do
    expect(BackEndService.get_gyms(31).class).to eq(Hash)
  end

  it 'can parse workout events json', :vcr do
    expect(BackEndService.get_events(1).class).to eq(Hash)
  end

  it 'can parse searched gyms json', :vcr do
    expect(BackEndService.gyms_near_user('80227').class).to eq(Hash)
  end

  it 'can parse one gym json', :vcr do
    result = BackEndService.get_one_gym('BJBXzKYxQAXZKb5W6HrRnA')
    expect(result.class).to eq(Hash)
  end

  it 'can create a gym membership', :vcr do
    json_response = File.read('./spec/fixtures/gym_membership.json')

    allow(BackEndService).to receive(:post_gym_membership).and_return(JSON.parse(json_response, symbolize_names: true))

    expect(BackEndService.post_gym_membership(json_response).class).to eq(Hash)
  end

  it "can parse a gym's users", :vcr do
    expect(BackEndService.get_gym_users("BJBXzKYxQAXZKb5W6HrRnA")).to be_a(Hash)
  end

  it 'can parse a gyms friends of the current user', :vcr do
    expect(BackEndService.get_friends_at_gym("BJBXzKYxQAXZKb5W6HrRnA")).to be_a(Hash)
  end

  it 'can parse a gyms non friends of the current user', :vcr do
    expect(BackEndService.get_non_friends_at_gym("BJBXzKYxQAXZKb5W6HrRnA")).to be_a(Hash)
  end
end
