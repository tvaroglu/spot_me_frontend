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

      it 'displays their user information' do
        within '#profile-header' do
          expect(page).to have_content(user10.full_name)
          expect(page).to have_content(user10.zip_code)
          expect(page).to have_content(user10.goal)
          expect(page).to have_content(user10.availability)
          expect(page).to have_content(user10.summary)
        end
      end

      it 'displays add friend button' do
        expect(page).to have_link('Follow')
      end

      context 'when I click on "Follow"' do
        before do
          allow(FriendshipService).to receive(:add_friend).and_return(user10_params)
          allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([])
        end

        it 'adds the user to my followers', :vcr do
          add_friend_params = {
            user_id: user.id.to_s,
            followee_id: user10.id.to_s
          }

          expect(FriendshipFacade).to receive(:add_friend).with(add_friend_params)

          click_on 'Follow'

          expect(page).to have_content('go get them gains!!')
        end

        it 'redirects me to the users profile page' do
          click_on 'Follow'
          
          expect(page).to have_current_path(profile_path(user10.id), ignore_query: true)
        end
      end
    end
  end
end
