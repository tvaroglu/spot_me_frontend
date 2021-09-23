require 'rails_helper'

RSpec.describe 'welcome page' do
  let(:user_blob) { File.read('./spec/fixtures/user.json') }

  it 'is on the correct page' do
    visit root_path

    expect(page).to have_content 'SpotMe'
    expect(page).to have_content 'Mission'
    expect(page).to have_link 'Sign in with Google'
  end

  it 'can log in and out of the application with a valid Google token', :vcr do
    visit root_path

    allow(BackEndService).to receive(:get_user)
      .and_return(JSON.parse(user_blob, symbolize_names: true))

    allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return([])

    # helper method defined in spec/support
    # see bottom of rails_helper for OmniAuth mock
    login_with_oauth
    expect(page).to have_current_path(dashboard_path(1), ignore_query: true)

    expect(page).to have_link 'Dashboard'
    expect(page).to have_button 'Find Gyms Near Me'
    expect(page).to have_link 'Log Out'

    click_on 'Log Out'
    expect(page).to have_content 'You are now logged out, please come back soon!'
    expect(page).to have_current_path(root_path)
  end

  describe 'new user registration' do
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
