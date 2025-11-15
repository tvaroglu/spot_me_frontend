require 'rails_helper'

describe 'gyms near me page', :vcr, type: :feature do
  # See spec/shared_contexts/features/current_user_shared_context.rb for context
  include_context 'logged in as authenticated user'

  before do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([])
    allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
    allow(EventFacade).to receive(:get_events).with(user.id).and_return([])
    allow(EventFacade).to receive(:get_events).with(user.id, 'past').and_return([])

    visit dashboard_index_path
    within('#find-gyms') { click_on 'Find Gyms Near Me' }
  end

  it 'can find gyms near me', :vcr do
    expect(page).to have_content("Gyms Near My Zip Code: #{user.zip_code}")
    # save_and_open_page
    within '#gyms' do
      gym_id = 'BJBXzKYxQAXZKb5W6HrRnA'
      within "##{gym_id}" do
        expect(page).to have_content("Rishi's Community Yoga")
        expect(page).to have_content('Denver, CO')
        expect(page).to have_content('(303)')
        expect(page).to have_content('Active Members')
      end
    end
  end

  it 'has a link to each individual gym', :vcr do
    gym_id = 'BJBXzKYxQAXZKb5W6HrRnA'
    within "##{gym_id}" do
      gym_name = "Rishi's Community Yoga"
      expect(page).to have_link(gym_name)
      click_on gym_name
    end

    expect(page).to have_current_path(gym_path(gym_id), ignore_query: true)
  end
end
