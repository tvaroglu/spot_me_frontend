require 'rails_helper'
RSpec.describe 'user dashboard' do
  before do
    visit dashboard_path
  end

  it "can display the user's attributes", :vcr do
    expect(page).to have_current_path(dashboard_path, ignore_query: true)
    # save_and_open_page
    expect(page).to have_content("Welcome, #{@user.full_name}!")
    expect(page).to have_content('My Friends')
    expect(page).to have_css('#friend', count: 3)

    expect(page).to have_content('My Gyms')
    expect(page).to have_css('#gym', count: 3)

    expect(page).to have_content('Upcoming Workouts')
    expect(page).to have_css('#event', count: 3)
  end
end
