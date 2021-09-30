require 'rails_helper'

describe 'user profile page: current user', type: :feature do
  context 'when I log in as an authenticated user', :vcr do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    before do
      allow(UserFacade).to receive(:get_user).with(user.id).and_return(user)
      allow(UserFacade).to receive(:get_profile_user).with(user.id.to_s).and_return(user)
      allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([])
      allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
      allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return([])
    end

    context 'when I visit my user profile' do
      before { visit profile_path(user.id) }

      it 'displays my name and zip code' do
        within '#profile-header' do
          expect(page).to have_content(user.full_name)
        end
      end

      it 'displays my zip code' do
        within '#zip-code' do
          expect(page).to have_content(user.zip_code)
        end
      end

      it 'displays my summary' do
        within '#user-summary' do
          expect(page).to have_content(user.summary)
        end
      end

      it 'displays my goal' do
        within '#goal' do
          expect(page).to have_content(user.goal)
        end
      end

      it 'displays my availability' do
        within '#availability' do
          expect(page).to have_content('Morning')
          expect(page).to have_content('Afternoon')
        end
      end

      it 'displays an "Edit Profile" button' do
        expect(page).to have_link('Edit Profile')
      end

      it 'displays add friend button' do
        expect(page).not_to have_link('Add Friend')
      end

      it 'displays delete friend button' do
        expect(page).not_to have_link('Remove Friend')
      end
    end
  end
end
