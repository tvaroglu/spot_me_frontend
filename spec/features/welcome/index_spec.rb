require 'rails_helper'

describe 'welcome page', type: :feature do
  include_context 'logged in as authenticated user'

  let(:user_blob) { File.read('./spec/fixtures/user.json') }
  let(:about) { "Find your future 'SwoleMate' or fitness bestie at your gym and schedule a workout together!" }

  it 'is on the correct page' do
    visit root_path

    expect(page).to have_content('SpotMe')
    expect(page).to have_content(about)
  end

  it 'can log in and out of the application with a valid Google token', :aggregate_failures, :vcr do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([])
    allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
    allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return([])

    visit root_path

    allow(UserService).to receive(:get_user)
      .and_return(JSON.parse(user_blob, symbolize_names: true))

    allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([])
    allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
    allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return([])

    # helper method defined in spec/support
    # see bottom of rails_helper for OmniAuth mock
    login_with_oauth
    expect(page).to have_current_path(dashboard_index_path, ignore_query: true)

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

      allow(UserService).to receive(:get_user)
        .and_return(JSON.parse(empty_user), symbolize_names: true)

      login_with_oauth
      expect(page).to have_current_path(new_registration_path, ignore_query: true)
    end
  end
end
