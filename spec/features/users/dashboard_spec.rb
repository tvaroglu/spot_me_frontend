require 'rails_helper'
RSpec.describe 'can visit a users show page' do
  before :each do

    visit dashboard_path
  end

  describe 'can visit a users dashboard' do
    it 'can visit a users show page and see there attributes' do
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.full_name}!")
      expect(page).to have_content("Emerson Cummerata")
      expect(page).to have_content("Stan Gutmann VM")
      expect(page).to have_content("Demetrius Bergstrom DVM")
    end

    it 'can see all the user gyms' do
      expect(page).to have_content("My Gyms")
      expect(page).to have_content("Gusikowski, Heller and Orn")
      expect(page).to have_content("Nolan LLC")
      expect(page).to have_content("Koss-Roberts")
    end

    it 'can see all the user workout events' do
      expect(page).to have_content("My Upcoming Workouts")
      expect(page).to have_content("Wednesday, Sep 29, 2021 6:43pm: Digital arts")
    end
  end
end
