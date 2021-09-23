require 'rails_helper'

RSpec.describe 'registration page' do
  describe 'happy path' do
    let(:user_blob) { File.read('./spec/fixtures/user.json') }

    it 'is on the correct page' do
      visit registration_path

      expect(page).to have_field(:full_name)
      expect(page).to have_field(:email)
      expect(page).to have_field(:zip_code)
      expect(page).to have_field(:summary)
      expect(page).to have_field(:goal)

      expect(page).to have_content('Availability')
      expect(page).to have_field(:availability_morning)
      expect(page).to have_field(:availability_afternoon)
      expect(page).to have_field(:availability_evening)

      expect(page).to have_button('Register')
    end

    it 'can register a new user if all required attributes are provided', :vcr do
      visit registration_path

      allow(BackEndService).to receive(:create_user).and_return(201)
      allow(BackEndService).to receive(:get_user)
        .and_return(JSON.parse(user_blob, symbolize_names: true))

      allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return([])
      allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])
      allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return([])

      fill_in :full_name, with: 'Foo Bar'
      fill_in :email, with: 'test@testing.com'
      fill_in :zip_code, with: '80227'
      fill_in :summary, with: 'Hello World'
      select 'Gain Muscle', from: :goal
      page.check :availability_morning

      click_on 'Register'

      expect(page).to have_current_path(dashboard_path(1), ignore_query: true)
    end
  end

  describe 'sad path' do
    let(:empty_user) { File.read('./spec/fixtures/empty_user.json') }

    it "can't register a new user if all required attributes aren't provided", :vcr do
      visit registration_path

      allow(BackEndService).to receive(:create_user).and_return(422)
      allow(BackEndService).to receive(:get_user)
        .and_return(JSON.parse(empty_user), symbolize_names: true)

      fill_in :full_name, with: 'Foo Bar'
      fill_in :email, with: 'test@testing.com'
      fill_in :zip_code, with: '80227'
      fill_in :summary, with: ''
      select 'Gain Muscle', from: :goal
      page.check :availability_morning

      click_on 'Register'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Couldn't create your account, please try again.")
    end
  end
end
