require 'rails_helper'
RSpec.describe 'user dashboard' do
  it "can display the user's attributes, friends, and gyms", :vcr do
    visit dashboard_path
    # save_and_open_page
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@user.zip_code)

    expect(page).to have_content('Upcoming Workouts')
    expect(page).to have_css('#event') # , count: 3)

    expect(page).to have_content('My Gyms')
    expect(page).to have_css('#gym') # , count: 3)

    expect(page).to have_content('My Friends')
    expect(page).to have_css('#friend') # , count: 3)
  end
end
