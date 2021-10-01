require 'rails_helper'

describe 'gyms show page: as a non-gym member', type: :feature do
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

    let(:gym_user_count) { GymUserCount.new(gym_member_count: 2) }

    context 'when I visit the gym show page that I am not a member of' do
      before do
        allow(GymFacade).to receive(:get_gym).with(yelp_gym_id).and_return(gym)
        allow(GymMembershipFacade).to receive(:get_gym_membership).with(yelp_gym_id: yelp_gym_id, user_id: current_user_id).and_return(nil)
        allow(GymFacade).to receive(:get_gym_users_count).with(yelp_gym_id).and_return(gym_user_count)

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

      it 'has a button to add the gym membership', :vcr do
        expect(page).to have_link('Add Gym')
      end

      context 'when I click "Add Gym"' do
        before do
          allow(GymMembershipFacade).to receive(:create_gym_membership).and_return(true)
          expect(GymMembershipFacade.create_gym_membership('some_params')).to eq(true)
          click_on 'Add Gym'
        end

        it 'redirects me bak to the gym page' do
          expect(page).to have_current_path(gym_path(yelp_gym_id))
        end
      end

      it 'does not display current gym members', :vcr do
        expect(page).to have_no_css('#my-friends')
        expect(page).to have_no_css('#non-friends')
      end
    end
  end
end
