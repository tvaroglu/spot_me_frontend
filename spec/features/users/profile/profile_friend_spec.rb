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
      allow(BackEndFacade).to receive(:get_user).with(user.id).and_return(user)
      allow(BackEndFacade).to receive(:get_profile_user).with(user10.id.to_s).and_return(user10)
      allow(BackEndFacade).to receive(:get_user_friends).with(user.id).and_return([user10])
      allow(BackEndFacade).to receive(:get_user_friends).with(user10.id).and_return([])
    end

    context 'when I visit my friends profile' do
      before { visit profile_path(user10.id) }

      it 'displays my friends name and zip code' do
        within '#profile-header' do
          expect(page).to have_content(user10.full_name)
          expect(page).to have_content(user10.zip_code)
        end
      end

      it 'displays my friends summary' do
        within '#user-summary' do
          expect(page).to have_content(user10.summary)
        end
      end

      it 'displays my friends goal' do
        within '#goal' do
          expect(page).to have_content(user10.goal)
        end
      end

      it 'displays my friends availability' do
        within '#availability' do
          expect(page).to have_content('Afternoon')
          expect(page).to have_content('Evening')
        end
      end

      it 'displays a "Remove Friend" button' do
        expect(page).to have_link('Remove Friend')
      end

      it 'can remove an existing friend', :vcr do
        allow(BackEndService).to receive(:delete_friend).and_return(204)
        allow(BackEndFacade).to receive(:get_user_gyms).with(user.id).and_return([])

        click_on 'Remove Friend'

        expect(page).to have_current_path(dashboard_index_path, ignore_query: true)
        expect(page).to have_content 'Swolemate removed!'
      end
    end
  end
end
