require 'rails_helper'

describe 'user profile page: friend', type: :feature do
  let(:user10_params) do
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
        availability_morning: false,
        availability_afternoon: true,
        availability_evening: true
      }
    }
  end

  let(:user10) { User.new(user10_params) }

  context 'when I log in as an authenticated user', :vcr do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    before do
      allow(UserFacade).to receive(:get_user).with(user.id).and_return(user)
      allow(UserFacade).to receive(:get_profile_user).with(user10.id.to_s).and_return(user10)
      allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([user10])
      allow(FriendshipFacade).to receive(:get_friends).with(user10.id).and_return([])
      allow(EventFacade).to receive(:get_events).with(user10.id).and_return([])
      allow(EventFacade).to receive(:get_events).with(user10.id, 'past').and_return([])
    end

    context 'when I visit my friends profile' do
      before { visit profile_path(user10.id) }

      it 'displays my friends user information' do
        within '#profile-header' do
          expect(page).to have_content(user10.full_name)
          expect(page).to have_content(user10.zip_code)
          expect(page).to have_content(user10.goal)
          expect(page).to have_content(user10.availability)
          expect(page).to have_content(user10.summary)
        end
      end

      it 'displays an "Unfollow" button' do
        expect(page).to have_link('Unfollow')
      end

      context 'when I click on the "Unfollow" link' do
        before do
          allow(FriendshipService).to receive(:delete_friend).and_return(204)
          allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
        end

        it 'removes the friend from my account', :vcr do
          destroy_friendship_params = {
            user_id: user.id.to_s,
            id: user10.id.to_s
          }

          expect(FriendshipFacade).to receive(:delete_friend).with(destroy_friendship_params)

          click_on 'Unfollow'

          expect(page).to have_content('SwoleMate removed!')
        end

        it 'redirects me to the users profile page', :vcr do
          click_on 'Unfollow'

          expect(page).to have_current_path(profile_path(user10.id), ignore_query: true)
        end
      end

      context 'when they have no upcoming workouts' do
        it 'displays an Upcoming Workouts section' do
          expect(page).to have_content('0 Upcoming Workouts')
          expect(page).to have_css('#upcoming-workouts')

          within '#upcoming-workouts' do
            expect(page).to have_content("#{user10.full_name} has no upcoming workouts.")
          end
        end
      end

      it 'displays a section with the users following the profile user (i.e. followers)' do
        expect(page).to have_css('#followers')

        within '#followers' do
          expect(page).to have_content("#{user10.full_name} has no followers.")
        end
      end
    end
  end
end
