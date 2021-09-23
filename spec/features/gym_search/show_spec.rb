require 'rails_helper'

RSpec.describe 'gyms show page' do
  before(:each) do
    allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return([])
    # allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return([])
    visit gym_path('BJBXzKYxQAXZKb5W6HrRnA')
  end

  it 'displays the gym and its information', :vcr do
    within '#gym_attributes' do
      expect(page).to have_content("Rishi's Community Yoga")
      expect(page).to have_content('2750 S Wadsworth Blvd, Bldg D, Ste 202, Denver, CO 80227')
      expect(page).to have_content('(303) 601-0789')

      expect(page).to have_css('h1', count: 1) # gym name
      expect(page).to have_css('p', count: 2) # gym address and phone
    end
  end

  it 'has a button to add the gym membership', :vcr do
    expect(page).to have_button('Add Gym')
  end

  it 'doesnt have a remove gym button if youre not registered', :vcr do
    expect(page).to_not have_button('Remove')
  end

  it 'does not display gym memberships if you arent a member', :vcr do
    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])

    visit dashboard_path(@user.id)

    expect(page).to_not have_content("Rishi's Community Yoga")
  end

  it 'adds the gym membership when you click that button', :vcr do
    visit gym_path('BJBXzKYxQAXZKb5W6HrRnA')

    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])

    click_on 'Add Gym'

    expect(current_path).to eq(dashboard_path(@user.id))
  end

  it 'displays the number of active members', :vcr do
    expect(page).to have_content("Number of Active Members: 1")
  end

  it 'has a button to remove the gym', :vcr do
    user1 = GymUser.new(
      {
        id: 10,
        attributes: {
          email: '123@test.com',
          full_name: 'Joe Shmoe',
          google_id: 123,
          google_image_url: 'pretty face',
          zip_code: '80227',
          summary: 'Muy guesta gimnasios',
          goal: 'Gain Weight',
          availability_morning: true,
          availability_afternoon: true,
          availability_evening: false
        }
      }
    )
      user2 = GymUser.new(
        id: 1,
        attributes: {
          email: '123@test.com',
          full_name: 'Joe Shmoe',
          google_id: 789,
          google_image_url: 'pretty face',
          zip_code: '80227',
          summary: 'Muy guesta gimnasios',
          goal: 'Gain Weight',
          availability_morning: true,
          availability_afternoon: true,
          availability_evening: false
        }
      )

    allow(BackEndFacade).to receive(:get_gym_users).with('BJBXzKYxQAXZKb5W6HrRnA').and_return([user1, user2])
    allow(BackEndFacade).to receive(:get_friends_at_gym).with('BJBXzKYxQAXZKb5W6HrRnA').and_return([user1])

    visit gym_path('BJBXzKYxQAXZKb5W6HrRnA')
    save_and_open_page
    expect(page).to have_link('Remove')
  end

  it 'actually removes the gym', :vcr do
    expect(page).to have_content("Rishi's Community Yoga")
    click_on 'Remove'

    expect(current_path).to eq(dashboard_path(current_user.id))
    expect(page).to_not have_content("Rishi's Community Yoga")
  end
end
