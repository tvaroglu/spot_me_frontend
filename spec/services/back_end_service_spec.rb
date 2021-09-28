require 'rails_helper'

describe BackEndService, type: :service do
  it 'can parse json' do
    json_blob = File.read('./spec/fixtures/user.json')

    expect(BackEndService.parse_json(json_blob).class).to eq(Hash)
  end

  it 'can send a json body' do
    json_response = File.read('./spec/fixtures/user.json')
    allow(UserService).to receive(:create_user).and_return(JSON.parse(json_response, symbolize_names: true))

    expect(UserService.create_user(json_response).class).to eq(Hash)
  end

  it 'can receive a request', :vcr do
    json_response = File.read('./spec/fixtures/user.json')
    allow(BackEndService).to receive(:parse_json)
      .and_return(JSON.parse(json_response, symbolize_names: true))

    expect(UserService.get_user(789).class).to eq(Hash)
  end
end
