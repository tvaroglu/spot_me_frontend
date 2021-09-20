require 'rails_helper'
RSpec.describe 'user dashboard' do
  before :each do
    visit dashboard_path
  end

  it "can display the user's attributes", :vcr do
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{@user.full_name}!")
    expect(page).to have_content('Emerson Cummerata')
    expect(page).to have_content('Stan Gutmann VM')
    expect(page).to have_content('Demetrius Bergstrom DVM')
  end

  it "can display the user's gyms", :vcr do
    expect(page).to have_content('My Gyms')
    expect(page).to have_content('Gusikowski, Heller and Orn')
    expect(page).to have_content('Nolan LLC')
    expect(page).to have_content('Koss-Roberts')
  end

  it "can display the user's upcoming workouts", :vcr do
    expect(page).to have_content('My Upcoming Workouts')
    expect(page).to have_content('Wednesday, Sep 29, 2021 6:43pm: Digital arts')
  end
end
