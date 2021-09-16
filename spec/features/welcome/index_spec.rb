require 'rails_helper'

RSpec.describe 'welcome page' do
  let(:headers) { {
    'Accept' => '*/*',
    'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    'User-Agent' => 'Faraday v1.7.1'
    # 'Authorization'=>ENV['bearer']
  } }
  let(:user_blob) { File.read('./spec/fixtures/user.json') }
  let(:get_user_request) { stub_request(:get, "#{BackEndService.base_url}/users/1")
    .with(headers: headers)
    .to_return(status: 200, body: user_blob, headers: {}) }

  it 'is on the correct page' do
    visit root_path

    expect(page).to have_content('SpotMe')
    expect(page).to have_content('Mission')
    expect(page).to have_link('Sign in with Google')
  end

  it 'can log in to the application with valid Google token' do
    visit root_path

    allow(BackEndService).to receive(:get_user)
      .and_return(JSON.parse(JSON.parse(user_blob), symbolize_names: true))

    # helper method defined in spec/support
    # see bottom of rails_helper for OmniAuth mock
    login_with_oauth
    expect(current_path).to eq(dashboard_path(1))
  end
end
