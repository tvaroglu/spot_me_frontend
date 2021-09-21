require 'rails_helper'

RSpec.describe 'gyms show page' do
  before(:each) do
    visit gym_path('BJBXzKYxQAXZKb5W6HrRnA')
  end

  it 'displays the gym and its information', :vcr do
    expect(page).to have_content("Rishi's Community Yoga")
    expect(page).to have_content('2750 S Wadsworth Blvd, Bldg D, Ste 202, Denver, CO 80227')
    expect(page).to have_content('(303) 601-0789')
  end
end


# As an authenticated user,
# When I visit the Find Gyms index page
# And I click on the gym name
# It redirects me to the Gym Show page
# And I see the following information:
#
#  Gym Name
#  "Add Gym" Button
#  Gym Address
#  Gym Phone Number
#  Number of Active Members
