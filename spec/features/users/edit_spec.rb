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
    json_response = File.read('./spec/fixtures/user.json')
    expect(page).to have_field('Name', with: "#{@user.full_name}")
    expect(page).to have_field('Email', with: "#{@user.email}")
    expect(page).to have_field('Zip Code', with: "#{@user.zip_code}")
    expect(page).to have_field('Summary', with: "#{@user.summary}")
    expect(page).to have_field('Goals', with: "#{@user.goal}")

    fill_in("Summary", with: "Joe Mama")

    allow(BackEndService).to receive(:update_user).and_return(JSON.parse(json_response, symbolize_names: true))

    click_button("Update Profile")

    expect(current_path).to eq("/profile/#{@user.id}")
    expect(page).to have_content("Successfully updated your profile!")
  end

  it 'can fill out a form to update a user and gives a flash message when you successfully update a user' do
    expect(page).to have_field('Name', with: "#{@user.full_name}")
    expect(page).to have_field('Email', with: "#{@user.email}")
    expect(page).to have_field('Zip Code', with: "#{@user.zip_code}")
    expect(page).to have_field('Summary', with: "#{@user.summary}")
    expect(page).to have_field('Goals', with: "#{@user.goal}")

    fill_in("Summary", with: "")

    error_response = {                        
                      :message=>"your query could not be completed",
                      :errors=>[
                      "Couldn't find User with 'id'=40"
                                ]
                      }

    allow(BackEndService).to receive(:update_user).and_return(error_response)

    click_button("Update Profile")

    expect(current_path).to eq(profile_edit_path(@user.id))
    expect(page).to have_content("Could not update your profile please try again!")
  end
end