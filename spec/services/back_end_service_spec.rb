require 'rails_helper'

RSpec.describe BackEndService do
  it 'can retrieve the base url for API calls' do
    expect(BackEndService.base_url).to eq 'http://localhost:3000/api/v1'
  end

  xit 'can receive a request' do
    json_response = File.read('spec/fixtures/user.json')
      stub_request(:get, "/users/12345").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.7.0'
          }).
      to_return(status: 200, body: json_response, headers: {})


    expect(BackEndService.get_user(12345).class).to eq(Hash)
  end
end
