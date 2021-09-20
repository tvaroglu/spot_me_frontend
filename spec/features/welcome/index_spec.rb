require 'rails_helper'

RSpec.describe 'welcome page' do
  let(:user_blob) { File.read('./spec/fixtures/user.json') }

  it 'is on the correct page' do
    visit root_path

    expect(page).to have_content('SpotMe')
    expect(page).to have_content('Mission')
    expect(page).to have_link('Sign in with Google')
  end

  it 'can log in to the application with valid Google token', :vcr do
    visit root_path

    allow(BackEndService).to receive(:get_user)
      .and_return(JSON.parse(user_blob, symbolize_names: true))

    # helper method defined in spec/support
    # see bottom of rails_helper for OmniAuth mock
    login_with_oauth
    expect(page).to have_current_path(dashboard_path(1), ignore_query: true)
  end

  describe 'sad path' do
    let(:empty_user) { File.read('./spec/fixtures/empty_user.json') }

    it 'will redirect to registration page if new user' do
      visit root_path

      allow(BackEndService).to receive(:get_user)
        .and_return(JSON.parse(empty_user), symbolize_names: true)

      login_with_oauth
      expect(page).to have_current_path(registration_path, ignore_query: true)
    end
  end
end
