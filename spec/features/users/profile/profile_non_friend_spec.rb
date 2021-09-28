require 'rails_helper'

describe 'user profile page: non-friend', type: :feature do
  let(:user10_params) do
    {
      id: 11,
      attributes: {
        email: '123@test.com',
        full_name: 'Joe Shmoe',
        google_id: 123,
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

  let(:user10) { User.new(user10_params) }

  context 'when I log in as an authenticated user', :vcr do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    before do
      allow(UserFacade).to receive(:get_user).with(user.id).and_return(user)
      allow(UserFacade).to receive(:get_profile_user).with(user10.id.to_s).and_return(user10)
      allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([])
      allow(FriendshipFacade).to receive(:get_friends).with(user10.id).and_return([])
    end

    context 'when I visit a non-friend user profile' do
      before { visit profile_path(user10.id) }

      it 'displays their name and zip code' do
        within '#profile-header' do
          expect(page).to have_content(user10.full_name)
          expect(page).to have_content(user10.zip_code)
        end
      end

      it 'displays their summary' do
        within '#user-summary' do
          expect(page).to have_content(user10.summary)
        end
      end

      it 'displays their goal' do
        within '#goal' do
          expect(page).to have_content(user10.goal)
        end
      end

      it 'displays their availability' do
        within '#availability' do
          expect(page).to have_content('Morning')
          expect(page).to have_content('Evening')
        end
      end

      it 'displays add friend button' do
        expect(page).to have_link('Add Friend')
      end

      it 'can add a new friend', :vcr do
        allow(FriendshipService).to receive(:add_friend).and_return(user10_params)
        allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])

        click_on 'Add Friend'

        expect(page).to have_current_path(dashboard_index_path, ignore_query: true)
        expect(page).to have_content('go get them gains!!')
      end
    end
  end
end
