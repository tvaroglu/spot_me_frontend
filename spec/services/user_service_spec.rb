require 'rails_helper'

describe UserService, type: :service do
  it 'can receive a request', :vcr do
    json_response = File.read('./spec/fixtures/user.json')
    allow(UserService).to receive(:parse_json)
      .and_return(JSON.parse(json_response, symbolize_names: true))

    expect(UserService.get_user(789).class).to eq(Hash)
  end
end
