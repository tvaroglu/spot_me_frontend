require 'rails_helper'

describe 'gyms show page: as a non-gym member', type: :feature do
  let(:current_user_id) { @user.id }
  let(:yelp_gym_id) { 'BJBXzKYxQAXZKb5W6HrRnA' }
  let(:name) { 'Planet Fitness' }
  let(:address) { '123 Main St' }
  let(:phone) { '123-123-1234' }

  let(:gym) do
    YelpGym.new(
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
        yelp_gym_id: yelp_gym_id,
      }
    )
  end

  let(:gym_user_count) { GymUserCount.new(gym_member_count: 2) }

  describe 'as an authenticated user' do
    context 'when I visit the gym show page that I am not a member of' do
      before do
        allow(BackEndFacade).to receive(:get_selected_gym).with(yelp_gym_id).and_return(gym)
        allow(BackEndFacade).to receive(:get_gym_membership).with(yelp_gym_id: yelp_gym_id, user_id: current_user_id).and_return(nil)
        allow(BackEndFacade).to receive(:get_gym_users_count).with(yelp_gym_id).and_return(gym_user_count)

        visit gym_path(yelp_gym_id)
      end

      it 'displays the gym and its information', :vcr do
        within '#gym-details' do
          expect(page).to have_content(name)
          expect(page).to have_content(address)
          expect(page).to have_content(phone)
        end
      end

      it 'displays the number of active members', :vcr do
        within '#active-members' do
          expect(page).to have_content("Number of Active Members: 2")
        end
      end

      it 'has a button to add the gym membership', :vcr do
        expect(page).to have_link('Add Gym')
      end

      it 'does not display current gym members', :vcr do
        expect(page).to have_no_css('#my-friends')
        expect(page).to have_no_css('#non-friends')
      end
    end
  end
end
