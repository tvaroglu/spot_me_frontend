require 'rails_helper'
RSpec.describe 'new user dashboard' do
  let(:empty_arr) { [] }

  before do
    allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return(empty_arr)
    allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return(empty_arr)
    allow(BackEndFacade).to receive(:get_user_events).with(@user.id).and_return(empty_arr)
    allow(BackEndFacade).to receive(:get_gyms_near_user).with(@user.zip_code).and_return(empty_arr)
  end

  context 'when I log in as an authenticated user' do
    context 'when I visit my user dashboard' do
      before { visit dashboard_path(@user.id) }

      context "when I don't have any friends" do
        it 'displays "You currently have no friends."', :vcr do
          within '#friends' do
            expect(page).to have_content('You currently have no friends.')
          end
        end
      end

      context "when I don't have any gyms" do
        it 'displays "You currently are not a member of any gyms."', :vcr do
          within '#gyms' do
            expect(page).to have_content('You currently are not a member of any gyms.')
          end
        end
      end

      context "when I don't have any workouts" do
        it 'displays "You currently have no upcoming workouts."', :vcr do
          within '#upcoming-workouts' do
            expect(page).to have_content('You currently have no upcoming workouts.')
          end
        end
      end
    end
  end
end
