require 'rails_helper'
RSpec.describe 'can visit a users show page' do
  before :each do

    visit dashboard_path
  end

  describe 'can visit a users dashboard' do
    it 'can visit a users show page and see there attributes' do
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Welcome, #{@user.full_name}!")
      expect(page).to have_content("Lashawn Baumbach")
      expect(page).to have_content("Kayce Witting DC")
      expect(page).to have_content("Cortez Goldner")
    end

    it 'can see all the user gyms' do
      expect(page).to have_content("My Gyms")
      expect(page).to have_content("6s6y4iljmrs93b7gwqyadz")
      expect(page).to have_content("jpk4ts58432183cz0w9yyw")
      expect(page).to have_content("lnjnx75zjtkf727da1p30c")
    end

    it 'can see all the user workout events' do
      expect(page).to have_content("My Upcoming Workouts")
      expect(page).to have_content("2021-09-27T16:52:22.095Z: Brazilian jiu-jitsu")
    end
  end
end
