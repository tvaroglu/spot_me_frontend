require 'rails_helper'
RSpec.describe 'user profile page' do
  it 'can show the attributes of the current user', :vcr do
    visit profile_path(@user.id)
    # save_and_open_page
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@user.zip_code)
    expect(page).to have_content(@user.summary)
    expect(page).to have_content(@user.goal)

    expect(page).to have_content('Availability')
    expect(page).to have_content('Afternoon')
    expect(page).to have_content('Evening')
  end
end
