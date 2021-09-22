require 'rails_helper'
RSpec.describe 'user dashboard' do
  let(:user1_params) do
    {
      id: 1,
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
      id: 2,
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

  let(:user3_params) do
    {
      id: 3,
      attributes: {
        email: '345@test.com',
        full_name: 'Jane Doe',
        google_id: 345,
        google_image_url: 'pretty face',
        zip_code: '80227',
        summary: 'Muy guesta gimnasios',
        goal: 'Gain Weight',
        availability_morning: false,
        availability_afternoon: false,
        availability_evening: true
      }
    }
  end

  let(:gym1_params) do
    {
      id: '1',
      type: 'gym',
      attributes: {
        name: 'gym1',
        address: 'address1',
        phone: '123-123-1234'
      }
    }
  end

  let(:gym2_params) do
    {
      id: '2',
      type: 'gym',
      attributes: {
        name: 'gym2',
        address: 'address2',
        phone: '234-234-2345'
      }
    }
  end

  let(:gym3_params) do
    {
      id: '3',
      type: 'gym',
      attributes: {
        name: 'gym3',
        address: 'address3',
        phone: '345-345-3456'
      }
    }
  end

  let(:event1_params) do
    {
      id: '1',
      attributes: {
        user_id: 2,
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
        user_id: 3,
        gym_membership_id: 2,
        date_time: '2022-08-22T21:41:28.289Z',
        activity: 'Running'
      }
    }
  end

  let(:event3_params) do
    {
      id: '3',
      attributes: {
        user_id: 2,
        gym_membership_id: 3,
        date_time: '2022-09-22T21:41:28.289Z',
        activity: 'Stretching'
      }
    }
  end

  let(:user_friends) { [User.new(user1_params), User.new(user2_params), User.new(user3_params)] }
  let(:user_gyms) { [YelpGym.new(gym1_params), YelpGym.new(gym2_params), YelpGym.new(gym3_params)] }
  let(:user_events) { [UserEvent.new(event1_params), UserEvent.new(event2_params), UserEvent.new(event3_params)] }

  before do
    allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return(user_friends)
    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return(user_gyms)
    allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return(user_events)
  end

  context 'as an authenticated user' do
    context 'when I visit my user dashboard' do
      before { visit dashboard_path(@user.id) }

      it 'displays my name and zip code', :vcr do
        save_and_open_page
        expect(page).to have_css("#profile-header")

        within '#profile-header' do
          expect(page).to have_content(@user.full_name)
          expect(page).to have_content(@user.zip_code)
        end
      end

      it 'displays a link to view my profile', :vcr do
        expect(page).to have_css('#profile')

        within '#profile' do
          expect(page).to have_link('View Profile')
        end
      end

      it 'displays the users I follow', :vcr do
        expect(page).to have_css('#friends')

        within '#friends' do
          expect(page).to have_content('My Friends')

          user_friends.each do |friend|
            expect(page).to have_css("#friend-#{friend.id}")

            within "#friend-#{friend.id}" do
              expect(page).to have_content(friend.full_name)
              expect(page).to have_link('View Profile')
              expect(page).to have_link('Remove')
            end
          end
        end
      end

      it 'displays my upcoming workouts', :vcr do
        expect(page).to have_css("#upcoming-workouts")

        within '#upcoming-workouts' do
          expect(page).to have_content('Upcoming Workouts')

          user_events.each do |event|
            expect(page).to have_css("#event-#{event.id}")

            within "#event-#{event.id}" do
              expect(page).to have_content(event.activity)
              expect(page).to have_link('Delete')
            end
          end
        end
      end

      it 'displays the gyms I am a member at', :vcr do
        expect(page).to have_css('#gyms')

        within '#gyms' do
          expect(page).to have_content('My Gyms')

          user_gyms.each do |gym|
            expect(page).to have_css("#gym-#{gym.yelp_gym_id}")

            within "#gym-#{gym.yelp_gym_id}" do
              expect(page).to have_content(gym.name)
              expect(page).to have_link('View Gym')
              expect(page).to have_link('Remove')
            end
          end
        end
      end

      it 'has a Find Gyms Near me button', :vcr do
        expect(page).to have_css('#gyms')

        within '#gyms' do
          expect(page).to have_link('Find Gyms Near Me')
        end
      end

      it 'can find gyms near me', :vcr do
        within '#gyms' do
          click_on 'Find Gyms Near Me'
        end

        expect(page).to have_current_path("/gyms?zip_code=#{@user.zip_code}")
      end
    end
  end
end

# TODO:
#  Features:
#    - Friends Button Link Redirects: 'View Profile', 'Remove'
#    - Gyms Button Link Redirects: 'View Gym', 'Remove'
#    - Events Button Link Redirect: 'Delete'
#   Edge Cases:
#     - When I have no friends, it displays "You currently have no friends."
#     - When I have no upcoming workouts, it displays "You currently have no upcoming workouts."
#     - When I have no gyms, it displays "You currently are not a member of any gyms."
