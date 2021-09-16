require 'rails_helper'

RSpec.describe 'registration page' do
  describe 'happy path' do
    it 'is on the correct page' do
      visit registration_path

      expect(page).to have_field(:email)
      expect(page).to have_field(:name)
      expect(page).to have_field(:zip_code)
      expect(page).to have_field(:summary)
      expect(page).to have_field(:goal)

      expect(page).to have_content('Availability')
      expect(page).to have_field(:availability_morning)
      expect(page).to have_field(:availability_afternoon)
      expect(page).to have_field(:availability_evening)

      expect(page).to have_button('Register')
    end

    it 'can register a new user if all required attributes are provided' do
      # stuff
    end
  end

  describe 'sad path' do
    xit "can't register a new user if all required attributes are provided" do
      # stuff
    end
  end
end
