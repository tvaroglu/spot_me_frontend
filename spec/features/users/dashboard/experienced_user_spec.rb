require 'rails_helper'

describe 'experienced user dashboard', type: :feature do
  context 'when I log in as an authenticated user' do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'
    # See spec/shared_contexts/features/experienced_user_shared_context.rb for context
    include_context 'experienced user'

    context 'when I visit my user dashboard' do
      before { visit dashboard_index_path }

      it 'displays my user details', :vcr do
        expect(page).to have_css('#profile-header')

        within '#profile-header' do
          expect(page).to have_content(user.full_name)
          expect(page).to have_content(user.zip_code)
          expect(page).to have_content(user.goal)
          expect(page).to have_content(user.availability)
          expect(page).to have_content(user.summary)
        end
      end

      it 'displays a link to view my profile', :vcr do
        expect(page).to have_css('#profile-header')

        within '#profile-header' do
          expect(page).to have_link('View Profile')
        end
      end

      it 'displays a link to edit my profile', :vcr do
        expect(page).to have_css('#profile-header')

        within '#profile-header' do
          expect(page).to have_link('Edit Profile')
        end
      end

      it 'displays a profile nav bar with anchor links' do
        within '#profile-nav' do
          expect(page).to have_link("#{user_events.size} Upcoming Workouts", href: '#my-upcoming-workouts')
          expect(page).to have_link('My Gyms', href: '#my-gyms')
          expect(page).to have_link("#{user_friends.size} Following", href: '#my-friends')
          expect(page).to have_link('Followers', href: '#my-followers')
        end
      end

      it 'displays my upcoming workouts', :vcr do
        expect(page).to have_css('#upcoming-workouts')
        within '#upcoming-workouts' do
          user_events.each do |event|
            expect(page).to have_css("#event-#{event.id}")

            within "#event-#{event.id}" do
              expect(page).to have_link(event.gym_name)
              expect(page).to have_content(event.activity)
              expect(page).to have_content(event.format_date_short)
              expect(page).to have_content("With: #{event.friend_name}")
              expect(page).to have_link('Delete')
            end
          end
        end
      end

      it 'displays the number of upcoming workouts' do
        within '#my-upcoming-workouts' do
          expect(page).to have_content("#{user_events.size} Upcoming Workouts")
        end
      end

      context 'when I click "Delete" on one of the upcoming workouts' do
        before do
          allow(EventService).to receive(:delete_event).and_return(204)
          event = user_events.last

          within "#event-#{event.id}" do
            click_on 'Delete'
          end
        end

        it 'redirects me to my dashboard', :vcr do
          expect(page).to have_current_path(dashboard_index_path)
        end

        it 'removes the event from my dashboard', :vcr do
          expect(page).to have_content('Workout deleted')
        end
      end

      it 'displays the gyms I am a member at', :vcr do
        expect(page).to have_css('#gyms')

        within '#gyms' do
          user_gym_memberships.each do |gym|
            expect(page).to have_css("#gym-#{gym.yelp_gym_id}")

            within "#gym-#{gym.yelp_gym_id}" do
              expect(page).to have_link(gym.gym_name)
              expect(page).to have_content(gym.address1)
              expect(page).to have_content(gym.city_state_zip)
              expect(page).to have_link('Remove')
            end
          end
        end
      end

      context 'when I click "Remove" on one of the gyms I am a member of' do
        before do
          allow(GymMembershipService).to receive(:delete_gym_membership).and_return(204)
          gym = gyms_near_user.last

          within "#gym-#{gym.yelp_gym_id}" do
            click_on 'Remove'
          end
        end

        it 'redirects me to my dashboard', :vcr do
          expect(page).to have_current_path(dashboard_index_path)
        end

        it 'removes the gym from my dashboard', :vcr do
          expect(page).to have_content('Gym removed')
        end
      end

      it 'has a Find Gyms Near Me button', :vcr do
        expect(page).to have_css('#find-gyms')

        within '#find-gyms' do
          expect(page).to have_link('Find Gyms Near Me')
        end
      end

      context 'when I click on "Find Gyms Near Me"' do
        before do
          within('#find-gyms') { click_on 'Find Gyms Near Me' }
        end

        it 'redirects me to the gym search page', :vcr do
          expect(page).to have_current_path("/gyms?zip_code=#{user.zip_code}")
          expect(page).to have_content(user.zip_code)
        end
      end

      it 'displays the users I follow', :vcr do
        expect(page).to have_css('#friends')

        within '#friends' do
          user_friends.each do |friend|
            expect(page).to have_css("#friend-#{friend.id}")

            within "#friend-#{friend.id}" do
              expect(page).to have_content(friend.full_name)
              expect(page).to have_content(friend.zip_code)
              expect(page).to have_content(friend.goal)
              expect(page).to have_content(friend.availability)
              expect(page).to have_link(friend.full_name)
              expect(page).to have_link('Unfollow')
            end
          end
        end
      end

      it 'displays the users that follow me', :vcr do
        expect(page).to have_css('#followers')

        within '#followers' do
          user_friends.each do |friend|
            expect(page).to have_css("#follower-#{friend.id}")

            within "#follower-#{friend.id}" do
              expect(page).to have_content(friend.full_name)
              expect(page).to have_content(friend.zip_code)
              expect(page).to have_content(friend.goal)
              expect(page).to have_content(friend.availability)
              expect(page).to have_link(friend.full_name)
            end
          end
        end
      end

      context 'when I click on one of my friends name' do
        let(:first_friend) { user_friends.first }

        before do
          allow(UserFacade).to receive(:get_user).with(first_friend.id.to_s).and_return(first_friend)
          allow(FriendshipFacade).to receive(:get_friends).with(first_friend.id.to_s).and_return([])
          allow(GymMembershipFacade).to receive(:get_gym_memberships).with(first_friend.id).and_return([])
          allow(EventFacade).to receive(:get_upcoming_events).with(first_friend.id.to_s).and_return([])

          within("#friend-#{first_friend.id}") { click_link first_friend.full_name }
        end

        it 'redirects me to my friends profile page', :vcr do
          expect(page).to have_current_path(profile_path(first_friend.id), ignore_query: true)
        end

        it 'displays a button "Remove Friend"', :vcr do
          expect(page).to have_link('Unfollow')
        end
      end
    end
  end
end
