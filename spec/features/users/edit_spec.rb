require 'rails_helper'
RSpec.describe 'Edit and update a current users profile by clicking a link on a users own page' do
  before :each do
    visit "/profile/#{@user.id}/edit"
  end

  it 'can click on the link on the current users profile page and be taken to the edit form' do
    visit "/profile/#{@user.id}"

    click_link("Edit Profile")

    expect(current_path).to eq("/profile/#{@user.id}/edit")
  end

  it 'can fill out a form to update a user and gives a flash message when you successfully update a user' do
    save_and_open_page
    expect(page).to have_content("Costco")
    click_link("update #{@merchant1.name}")

    fill_in("Name", with: "Kostco")

    click_button("Update #{@merchant1.name}")

    expect(page).to have_content("Merchant Successfully updated!")
    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
    expect(page).to have_content("Kostco")
    expect(page).to_not have_content("Costco")
  end

  xit 'gives a flash message when you do not successfully update a merchant' do
    expect(page).to_not have_content("Error: Name can't be blank")
    click_link("update #{@merchant1.name}")

    fill_in("Name", with: "")

    click_button("Update #{@merchant1.name}")

    expect(page).to have_content("Error: Name can't be blank")
  end
end