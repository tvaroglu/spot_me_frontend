require 'rails_helper'

RSpec.describe BackEndService do
  it 'can retrieve the base url for API calls' do
    expect(BackEndService.base_url).to eq 'https://spotme-app-api.herokuapp.com/api/v1'
  end

  it 'can receive a request' do
    json_response = File.read('spec/fixtures/user.json')
    stub_request(:get, "https://spotme-app-api.herokuapp.com/api/v1/users/789").
      with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v1.7.0'
          }).
          to_return(status: 200, body: json_response, headers: {})


    expect(BackEndService.get_user(789).class).to eq(Hash)
  end
end
