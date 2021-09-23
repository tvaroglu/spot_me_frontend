require 'rails_helper'

describe 'user profile page: non-friend', type: :feature do
  let(:user1_params) do
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

  let(:user10) { User.new(user1_params) }

  context 'when I log in as an authenticated user', :vcr do
    before do
      allow(BackEndFacade).to receive(:get_user).with(@user.id).and_return(@user)
      allow(BackEndFacade).to receive(:get_profile_user).with(user10.id.to_s).and_return(user10)
      allow(BackEndFacade).to receive(:get_user_friends).with(@user.id).and_return([])
      allow(BackEndFacade).to receive(:get_user_friends).with(user10.id).and_return([])
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

      it 'can add a friend', :vcr do
        allow(BackEndService).to receive(:create_friendship).and_return(user1_params)
        allow(BackEndFacade).to receive(:get_user_gyms).with(@user.id).and_return([])
        
        click_on 'Add Friend'

        expect(current_path).to eq(dashboard_path(@user.id))
        expect(page).to have_content("go get them gains!!")
      end

      it 'displays delete friend button' do
        expect(page).to have_link('Remove Friend')
      end
    end
  end
end
