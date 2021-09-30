require 'rails_helper'

describe 'experienced user dashboard', type: :feature do
  context 'when I log in as an authenticated user' do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    let(:user1) do
      User.new(
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
      )
    end

    let(:user2) do
      User.new(
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
      )
    end

    let(:user3) do
      User.new(
        id: 30,
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
      )
    end

    let(:gym_membership1) do
      GymMembership.new(
        id: '1',
        type: 'gym_membership',
        attributes: {
          user_id: 1,
          yelp_gym_id: 'lex65fkcol5gfq89rymmd2',
          gym_name: 'Kling-Wilkinson'
        }
      )
    end

    let(:gym_membership2) do
      GymMembership.new(
        id: '7',
        type: 'gym_membership',
        attributes: {
          user_id: 1,
          yelp_gym_id: '6x10s0lbnry4ivkzcjpilk',
          gym_name: 'Konopelski, Lowe and Haley'
        }
      )
    end

    let(:gym_membership3) do
      GymMembership.new(
        id: '17',
        type: 'gym_membership',
        attributes: {
          user_id: 1,
          yelp_gym_id: 'wxaw9m796t6wdnsk53uieh',
          gym_name: 'Funk LLC'
        }
      )
    end

    let(:yelp_gym1) do
      Gym.new(
        id: '1',
        type: 'gym',
        attributes: {
          name: 'Planet Fitness',
          address: 'address1',
          phone: '123-123-1234'
        }
      )
    end

    let(:yelp_gym2) do
      Gym.new(
        id: '2',
        type: 'gym',
        attributes: {
          name: 'Golds Gym',
          address: 'address2',
          phone: '234-234-2345'
        }
      )
    end

    let(:yelp_gym3) do
      Gym.new(
        id: '3',
        type: 'gym',
        attributes: {
          name: '24Hour Fitness',
          address: 'address3',
          phone: '345-345-3456'
        }
      )
    end

    let(:event1) do
      Event.new(
        id: '1',
        attributes: {
          user_id: 20,
          gym_membership_id: 1,
          activity: 'Bodybuilding',
          date_time: '2022-07-22T21:41:28.000Z'
        },
        relationships: {
          user: {
            meta: {
              full_name: user2.full_name
            }
          }
        }
      )
    end

    let(:event2) do
      Event.new(
        id: '2',
        attributes: {
          user_id: 30,
          gym_membership_id: 2,
          date_time: '2022-08-22T21:41:28.000Z',
          activity: 'Running'
        },
        relationships: {
          user: {
            meta: {
              full_name: user3.full_name
            }
          }
        }
      )
    end

    let(:event3) do
      Event.new(
        id: '3',
        attributes: {
          user_id: 20,
          gym_membership_id: 3,
          date_time: '2022-09-22T21:41:28.000Z',
          activity: 'Stretching'
        },
        relationships: {
          user: {
            meta: {
              full_name: user2.full_name
            }
          }
        }
      )
    end

    let(:user_friends) { [user1, user2, user3] }
    let(:user_gyms) { [gym_membership1, gym_membership2, gym_membership3] }
    let(:searched_gyms) { [yelp_gym1, yelp_gym2, yelp_gym3] }
    let(:user_events) { [event1, event2, event3] }

    before do
      allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return(user_friends)
      allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return(user_gyms)
      allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return(user_events)
      allow(GymFacade).to receive(:get_gyms_near_user).with(user.zip_code).and_return(searched_gyms)
    end

    context 'when I visit my user dashboard' do
      before { visit dashboard_index_path }

      it 'displays my name and zip code', :vcr do
        expect(page).to have_css('#profile-header')

        within '#profile-header' do
          expect(page).to have_content(user.full_name)
        end
      end

      it 'displays a link to view my profile', :vcr do
        expect(page).to have_css('#profile-header')

        within '#profile-header' do
          expect(page).to have_link('View')
        end
      end

      it 'displays the users I follow', :vcr do
        expect(page).to have_css('#friends')

        within '#friends' do
          user_friends.each do |friend|
            expect(page).to have_css("#friend-#{friend.id}")

            within "#friend-#{friend.id}" do
              expect(page).to have_content(friend.full_name)
              expect(page).to have_link(friend.full_name)
              expect(page).to have_link('Unfollow')
            end
          end
        end
      end

      context 'when I click on "View" next to one of my friends' do
        let(:first_friend) { user_friends.first }

        before do
          allow(UserFacade).to receive(:get_user).with(first_friend.id.to_s).and_return(first_friend)
          allow(FriendshipFacade).to receive(:get_friends).with(first_friend.id.to_s).and_return([])
          allow(GymMembershipFacade).to receive(:get_gym_memberships).with(first_friend.id).and_return([])
          allow(EventFacade).to receive(:get_upcoming_events).with(first_friend.id).and_return([])
          within("#friend-#{first_friend.id}") { click_link first_friend.full_name }
        end

        it 'redirects me to my friends profile page', :vcr do
          expect(page).to have_current_path(profile_path(first_friend.id), ignore_query: true)
        end

        it 'displays a button "Remove Friend"', :vcr do
          expect(page).to have_link('Unfollow')
        end
      end

      it 'has a Find Gyms Near Me button', :vcr do
        expect(page).to have_css('#find-gyms')

        within '#find-gyms' do
          expect(page).to have_link('Find Gyms Near Me')
        end
      end

      it 'can find gyms near me', :vcr do
        within '#find-gyms' do
          click_on 'Find Gyms Near Me'
        end

        expect(page).to have_current_path("/gyms?zip_code=#{user.zip_code}")
      end

      it 'displays the gyms I am a member at', :vcr do
        expect(page).to have_css('#gyms')

        within '#gyms' do
          user_gyms.each do |gym|
            expect(page).to have_css("#gym-#{gym.yelp_gym_id}")

            within "#gym-#{gym.yelp_gym_id}" do
              expect(page).to have_content(gym.gym_name)
              expect(page).to have_link(gym.gym_name)
              expect(page).to have_link('Remove')
            end
          end
        end
      end

      it 'displays a link to delete a gym', :vcr do
        allow(GymMembershipService).to receive(:delete_gym_membership).and_return(204)
        gym = user_gyms.last

        within "#gym-#{gym.yelp_gym_id}" do
          click_on 'Remove'
        end

        expect(page).to have_current_path(dashboard_index_path)
        expect(page).to have_content('Gym removed')
      end

      it 'displays my upcoming workouts', :vcr do
        expect(page).to have_css('#upcoming-workouts')

        within '#upcoming-workouts' do
          user_events.each do |event|
            expect(page).to have_css("#event-#{event.id}")

            within "#event-#{event.id}" do
              expect(page).to have_content(event.activity)
              expect(page).to have_link('Delete')
            end
          end
        end
      end

      it 'displays a link to delete a workout', :vcr do
        allow(EventService).to receive(:delete_event).and_return(204)
        event = user_events.last

        within "#event-#{event.id}" do
          click_on 'Delete'
        end

        expect(page).to have_current_path(dashboard_index_path)
        expect(page).to have_content('Workout deleted')
      end
    end
  end
end
