require 'rails_helper'

describe 'edit user profile', type: :feature do
  # See spec/shared_contexts/features/current_user_shared_context.rb for context
  include_context 'logged in as authenticated user'

  let(:user1_params) do
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
  end

  let(:user2_params) do
    {
      id: 20,
      attributes: {
        email: '234@test.com',
        full_name: 'John Doe',
        google_id: 234,
        google_image_url: 'pretty face',
        zip_code: '80227',
        summary: 'Muy guesta gimnasios',
        goal: 'Gain Weight',
        availability_morning: true,
        availability_afternoon: false,
        availability_evening: true
      }
    }
  end

  let(:gym_membership1_params) do
    {
      id: '1',
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: 'lex65fkcol5gfq89rymmd2',
        gym_name: 'Kling-Wilkinson'
      }
    }
  end

  let(:gym_membership2_params) do
    {
      id: '7',
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: '6x10s0lbnry4ivkzcjpilk',
        gym_name: 'Konopelski, Lowe and Haley'
      }
    }
  end

  let(:event1_params) do
    {
      id: '1',
      attributes: {
        user_id: 20,
        gym_membership_id: 1,
        activity: 'Bodybuilding',
        date_time: '2022-07-22T21:41:28.289Z'
      }
    }
  end

  let(:event2_params) do
    {
      id: '2',
      attributes: {
        user_id: 30,
        gym_membership_id: 2,
        date_time: '2022-08-22T21:41:28.289Z',
        activity: 'Running'
      }
    }
  end

  let!(:user_blob) do
    {
      'full_name' => 'Joe Shmoe',
      'email' => '123@test.com',
      'zip_code' => '80227',
      'summary' => 'Joe Mama',
      'goal' => 'Gain Muscle',
      'availability_morning' => '1',
      'availability_afternoon' => '1',
      'availability_evening' => '0'
    }
  end

  let(:user_friends) { [User.new(user1_params), User.new(user2_params)] }
  let(:user_gyms) { [GymMembership.new(gym_membership1_params), GymMembership.new(gym_membership2_params)] }
  let(:user_events) { [Event.new(event1_params), Event.new(event2_params)] }

  before do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return(user_friends)
    allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return(user_gyms)
    allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return(user_events)
  end

  it "can click on the link from the current user's profile page and be taken to the edit form", :vcr do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id.to_s).and_return(user_friends)

    visit profile_path(user.id)
    click_on 'Edit Profile'

    expect(page).to have_current_path(edit_profile_path(user.id))
  end

  it 'can fill out a form to update a user and gives a flash message when you successfully update a user', :vcr do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id.to_s).and_return(user_friends)
    allow(UserService).to receive(:update_user).with(user_blob, user.id).and_return(user)

    visit edit_profile_path(user.id)

    expect(page).to have_field(:full_name, with: user.full_name.to_s)
    expect(page).to have_field(:email, with: user.email.to_s)
    expect(page).to have_field(:zip_code, with: user.zip_code.to_s)
    expect(page).to have_field(:summary, with: user.summary.to_s)
    expect(page).to have_field(:goal, with: user.goal.to_s)

    fill_in :summary, with: 'Joe Mama'

    click_on 'Update Profile'

    expect(page).to have_current_path("/profile/#{user.id}", ignore_query: true)
    expect(page).to have_content('Your profile has been updated!')
  end
end
