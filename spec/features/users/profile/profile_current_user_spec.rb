require 'rails_helper'

describe 'user profile page: current user', type: :feature do
  context 'when I log in as an authenticated user', :vcr do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'
    # See spec/shared_contexts/features/experienced_user_shared_context.rb for context
    include_context 'experienced user'

    before do
      allow(UserFacade).to receive(:get_user).with(user.id).and_return(user)
      allow(UserFacade).to receive(:get_profile_user).with(user.id.to_s).and_return(user)
    end

    context 'when I visit my user profile' do
      before { visit profile_path(user.id) }

      it 'displays my user information' do
        within '#profile-header' do
          expect(page).to have_content(user.full_name)
          expect(page).to have_content(user.zip_code)
          expect(page).to have_content(user.goal)
          expect(page).to have_content(user.availability)
          expect(page).to have_content(user.summary)
        end
      end

      it 'displays an "Edit Profile" button' do
        within '#profile-header' do
          expect(page).to have_link('Edit Profile')
          expect(page).not_to have_link('Follow')
          expect(page).not_to have_link('Unfollow')
        end
      end

      context 'when I click on "Edit Profile"' do
        before { click_on 'Edit Profile' }

        it 'redirects me to the Edit Profile page' do
          expect(page).to have_current_path(edit_profile_path(user.id))
        end
      end

      it 'does not display an Upcoming Workouts section' do
        expect(page).not_to have_content('Upcoming Workouts')
        expect(page).not_to have_css('#upcoming-workouts')
      end

      it 'displays a section with the users I am following' do
        expect(page).to have_css('#friends')

        within '#friends' do
          user_friends.each do |friend|
            within "#friend-#{friend.id}" do
              expect(page).to have_content(friend.full_name)
              expect(page).to have_link(friend.full_name)
              expect(page).to have_content(friend.zip_code)
              expect(page).to have_content(friend.goal)
              expect(page).to have_content(friend.availability)
            end
          end
        end
      end

      it 'displays a section with the users following me (i.e. followers)' do
        expect(page).to have_css('#followers')

        within '#followers' do
          user_friends.each do |friend|
            within "#follower-#{friend.id}" do
              expect(page).to have_content(friend.full_name)
              expect(page).to have_link(friend.full_name)
              expect(page).to have_content(friend.zip_code)
              expect(page).to have_content(friend.goal)
              expect(page).to have_content(friend.availability)
            end
          end
        end
      end
    end
  end
end
