require 'rails_helper'
RSpec.describe 'user dashboard' do
  before do
    visit dashboard_path(@user.id)
  end

  it "can display the user's attributes, friends, and gyms", :vcr do
    expect(page).to have_content @user.full_name
    expect(page).to have_content @user.zip_code

    expect(page).to have_content 'Upcoming Workouts'
    expect(page).to have_css '#event' # , count: 3)

    expect(page).to have_content 'My Gyms'
    expect(page).to have_css '#gym' # , count: 3)

    expect(page).to have_content 'My Friends'
    expect(page).to have_css '#friend' # , count: 3)

    expect(page).to have_link 'View Profile'
  end

  it 'has a Find Gyms Near me button', :vcr do
    expect(page).to have_button('Find Gyms Near Me')
  end

  it 'can find gyms near me', :vcr do
    click_on 'Find Gyms Near Me'

    expect(page).to have_current_path('/gyms?zip_code=80227')
  end
end
