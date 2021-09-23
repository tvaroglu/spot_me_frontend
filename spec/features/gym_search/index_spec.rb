require 'rails_helper'

RSpec.describe 'gyms near me page', :vcr do
  before do
    allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return([])

    visit dashboard_path(@user.id)
    within('#gyms') { click_on 'Find Gyms Near Me' }
  end

  it 'can find gyms near me', :vcr do
    expect(page).to have_content("Gyms Near #{@user.zip_code}")

    within '#gyms' do
      expect(page).to have_css('div', count: 20)

      within '#BJBXzKYxQAXZKb5W6HrRnA' do
        expect(page).to have_content("Rishi's Community Yoga")
        expect(page).to have_content('2750 S Wadsworth Blvd, Bldg D, Ste 202, Denver, CO 80227')
        expect(page).to have_content('(303) 601-0789')
      end
    end
  end

  it 'has a link to each individual gym', :vcr do
    within '#BJBXzKYxQAXZKb5W6HrRnA' do
      expect(page).to have_link("Rishi's Community Yoga")
      click_on "Rishi's Community Yoga"
    end
      expect(current_path).to eq(gym_path('BJBXzKYxQAXZKb5W6HrRnA'))
      # expect(current_path).to eq('/gyms/BJBXzKYxQAXZKb5W6HrRnA')
  end
end
