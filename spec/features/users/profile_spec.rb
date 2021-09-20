require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    visit "/users/#{@user.id}/profile"
  end

  xit 'can show the attributes of the current user' do
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.summary)
    expect(page).to have_content(@user.availability_morning)
    expect(page).to have_content(@user.availability_afternoon)
    expect(page).to have_content(@user.availability_evening)

    expect(page).to have_content('Lashawn Baumbach')
    expect(page).to have_content('Kayce Witting DC')
    expect(page).to have_content('Cortez Goldner')
  end
end