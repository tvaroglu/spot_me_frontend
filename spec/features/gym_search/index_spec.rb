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
      # NOTE: gym no longer returned by Yelp API; adding a different one to fix legacy failing tests
      # within '#BJBXzKYxQAXZKb5W6HrRnA' do
      within '#hZkoTYYun1LpDy-pe4Gujg' do
        # expect(page).to have_content("Rishi's Community Yoga")
        # expect(page).to have_content('2750 S Wadsworth Blvd, Bldg D, Ste 202, Denver, CO 80227')
        # expect(page).to have_content('(303) 601-0789')
        expect(page).to have_content('Planet Fitness')
        expect(page).to have_content('3265 S Wadsworth Blvd, Lakewood, CO 80227')
        expect(page).to have_content('(303) 985-8888')
        expect(page).to have_content('Active Members')
      end
    end
  end

  it 'has a link to each individual gym', :vcr do
    # NOTE: gym no longer returned by Yelp API; adding a different one to fix legacy failing tests
    # within '#BJBXzKYxQAXZKb5W6HrRnA' do
    within '#hZkoTYYun1LpDy-pe4Gujg' do
      # expect(page).to have_link("Rishi's Community Yoga")
      # click_on "Rishi's Community Yoga"
      expect(page).to have_link('Planet Fitness')
      click_on 'Planet Fitness'
    end

    # expect(page).to have_current_path(gym_path('BJBXzKYxQAXZKb5W6HrRnA'), ignore_query: true)
    expect(page).to have_current_path(gym_path('hZkoTYYun1LpDy-pe4Gujg'), ignore_query: true)
  end
end
