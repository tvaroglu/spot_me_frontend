require 'rails_helper'

RSpec.describe BackEndService do
  it 'can retrieve the base url for API calls' do
    expect(BackEndService.base_url.class).to eq String
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
    expect(BackEndService.get_gyms(1).class).to eq(Hash)
  end

  it 'can parse workout events json', :vcr do
    expect(BackEndService.get_events(1).class).to eq(Hash)
  end

  # it 'can parse searched gyms json', :vcr do
  #   expect(BackEndService.gyms_near_user(1).class).to eq(Hash)
  # end
end
