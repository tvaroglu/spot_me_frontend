require 'rails_helper'

RSpec.describe 'registration page' do
  describe 'happy path' do
    let(:headers) do
      {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.7.1'
      # 'Authorization'=>ENV['bearer']
      }
    end

    let(:user_blob) { File.read('./spec/fixtures/user.json') }
    let(:get_user_request) do
      stub_request(:get, "#{BackEndService.base_url}/users/1")
        .with(headers: headers)
        .to_return(status: 200, body: user_blob, headers: {})
    end

    let(:post_user_request) do
      stub_request(:post, "#{BackEndService.base_url}/users")
        .with(headers: headers, body: user_blob)
        .to_return(status: 201, headers: {})
    end

    it 'is on the correct page' do
      visit registration_path

      expect(page).to have_field(:name)
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

    it 'can register a new user if all required attributes are provided' do
      visit registration_path

      # janky stub #1... not sure why the Webmock stub in the LET block above isn't blocking this request..
      allow(BackEndService).to receive(:send_request).and_return(201)
      # janky stub #2... have to double-JSON parse the fixture file for some reason..
      allow(BackEndService).to receive(:get_user)
        .and_return(JSON.parse(user_blob), symbolize_names: true)

      fill_in :name, with: 'Foo Bar'
      fill_in :email, with: 'test@testing.com'
      fill_in :zip_code, with: '80227'
      fill_in :summary, with: 'Hello World'
      select 'Gain Weight', from: :goal
      page.check :availability_morning

      click_on 'Register'

      expect(page).to have_current_path(dashboard_path(1), ignore_query: true)
    end
  end

  describe 'sad path' do
    let(:headers) do
      {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v1.7.1'
      # 'Authorization'=>ENV['bearer']
      }
    end

    let(:user_blob) { File.read('./spec/fixtures/empty_user.json') }
    let(:get_user_request) do
      stub_request(:get, "#{BackEndService.base_url}/users/1")
        .with(headers: headers)
        .to_return(status: 200, body: user_blob, headers: {})
    end

    let(:post_user_request) do
      stub_request(:post, "#{BackEndService.base_url}/users")
        .with(headers: headers, body: user_blob)
        .to_return(status: 400, headers: {})
    end

    it "can't register a new user if all required attributes are provided" do
      visit registration_path

      allow(BackEndService).to receive(:send_request).and_return(201)

      allow(BackEndService).to receive(:get_user)
        .and_return(JSON.parse(JSON.parse(user_blob), symbolize_names: true))

      fill_in :name, with: 'Foo Bar'
      fill_in :email, with: 'test@testing.com'
      fill_in :zip_code, with: '80227'
      fill_in :summary, with: ''
      select 'Gain Weight', from: :goal
      page.check :availability_morning

      click_on 'Register'

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Couldn't create your account, please try again.")
    end
  end
end
