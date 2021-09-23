require 'rails_helper'
RSpec.describe 'user profile page' do
  it 'can show the attributes of the current user', :vcr do
    allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return([])
    allow(BackEndFacade).to receive(:get_user).with(@user.id.to_s).and_return(@user)

    visit profile_path(@user.id)

    expect(page).to have_content @user.full_name
    expect(page).to have_content @user.zip_code
    expect(page).to have_content @user.summary
    expect(page).to have_content @user.goal

    expect(page).to have_content 'Availability'
    expect(page).to have_content 'Morning'
    expect(page).to have_content 'Afternoon'

    expect(page).to have_link 'Edit Profile'
  end
end
