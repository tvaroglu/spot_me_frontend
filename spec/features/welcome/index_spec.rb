require 'rails_helper'

RSpec.describe 'login page' do
  describe 'happy path' do
    it 'is on the correct page' do
      visit root_path

      expect(page).to have_content('SpotMe')
      expect(page).to have_content('Mission')

      expect(page).to have_link('Create an Account')

      # note, refactor as necessary per Oauth process
      expect(page).to have_link('Sign in with Google')
    end

    xit 'can log in to the application with valid Google token' do
      # stuff
    end
  end

  describe 'sad path' do
    xit "can't log in to the application without valid Google token" do
      # stuff
    end
  end
end
