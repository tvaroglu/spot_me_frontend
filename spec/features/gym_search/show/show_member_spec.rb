require 'rails_helper'

describe 'gyms show page: as a gym member', type: :feature do
  describe 'as an authenticated user' do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    let(:current_user_id) { user.id }
    let(:yelp_gym_id) { 'BJBXzKYxQAXZKb5W6HrRnA' }
    let(:name) { 'Planet Fitness' }
    let(:address) { '123 Main St' }
    let(:phone) { '123-123-1234' }

    let(:gym) do
      Gym.new(
        id: yelp_gym_id,
        type: 'gym',
        attributes: {
          name: name,
          address: address,
          phone: phone
        }
      )
    end

    let(:gym_membership) do
      GymMembership.new(
        id: 1,
        type: 'gym',
        attributes: {
          gym_name: name,
          yelp_gym_id: yelp_gym_id
        }
      )
    end

    let(:friend) do
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

    let(:non_friend) do
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

    let(:gym_user_count) { GymUserCount.new(gym_member_count: 2) }

    context 'when I visit the gym show page as a gym member' do
      before do
        allow(GymFacade).to receive(:get_gym).with(yelp_gym_id).and_return(gym)
        allow(GymMembershipFacade).to receive(:get_gym_membership).with(yelp_gym_id: yelp_gym_id, user_id: current_user_id).and_return(gym_membership)
        allow(GymFacade).to receive(:get_gym_users).with(yelp_gym_id).and_return([friend, non_friend])
        allow(GymFacade).to receive(:get_gym_users_count).with(yelp_gym_id).and_return(gym_user_count)
        allow(FriendshipFacade).to receive(:get_friends_at_gym).with(yelp_gym_id, current_user_id).and_return([friend])
        allow(FriendshipFacade).to receive(:get_non_friends_at_gym).with(yelp_gym_id: yelp_gym_id, user_id: current_user_id).and_return([non_friend])

        visit gym_path(yelp_gym_id)
      end

      it 'displays the gym and its information', :vcr do
        within '#gym-details' do
          expect(page).to have_content(name)
          expect(page).to have_content(address)
          expect(page).to have_content(phone)
          expect(page).to have_content('2 Active Members')
        end
      end

      it 'has a button to remove the gym', :vcr do
        expect(page).to have_link('Remove Gym')
      end

      it 'displays my friends who are gym members' do
        within '#my-friends' do
          expect(page).to have_content(friend.full_name)
          expect(page).to have_link(friend.full_name)
          expect(page).to have_link('Schedule Workout')
        end
      end

      it 'displays gym members who are not my friend' do
        within '#non-friends' do
          expect(page).to have_content(non_friend.full_name)
          expect(page).to have_link(non_friend.full_name)
          expect(page).to have_link('Follow')
        end
      end
    end
  end
end
