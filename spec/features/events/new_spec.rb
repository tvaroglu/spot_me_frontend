require 'rails_helper'
RSpec.describe 'new event page', type: :feature do
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

  let(:current_user_gym_membership) do
    GymMembership.new(
      id: '1',
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: 'lex65fkcol5gfq89rymmd2',
        gym_name: 'Planet Fitness'
      }
    )
  end

  let(:gym_membership2_params) do
    GymMembership.new(
      id: '2',
      type: 'gym_membership',
      attributes: {
        user_id: 10,
        yelp_gym_id: 'lex65fkcol5gfq89rymmd2',
        gym_name: 'Planet Fitness'
      }
    )
  end

  let(:gym1) do
    Gym.new(
      id: 'wxaw9m796t6wdnsk53uieh',
      type: 'gym',
      attributes: {
        name: 'Planet Fitness',
        address: 'address1',
        phone: '123-123-1234'
      }
    )
  end

  context 'when I log in as an authenticated user' do
    # See spec/shared_contexts/features/current_user_shared_context.rb for context
    include_context 'logged in as authenticated user'

    context 'when I visit the new event page' do
      let(:create_params) do
        {
          gym_membership_id: current_user_gym_membership.id,
          gym_name: current_user_gym_membership.gym_name,
          friend_id: friend.id,
          friend_name: friend.full_name
        }
      end

      before { visit new_event_path(create_params) }

      it 'displays the gym name' do
        expect(page).to have_content(current_user_gym_membership.gym_name)
      end

      it 'displays my friends name' do
        expect(page).to have_content(friend.full_name)
      end

      it 'displays a form to create an event' do
        expect(page).to have_field('activity')
        expect(page).to have_field('date[when(1i)]')
        expect(page).to have_field('date[when(2i)]')
        expect(page).to have_field('date[when(3i)]')
        expect(page).to have_field('time[start_time(4i)]')
        expect(page).to have_field('time[start_time(5i)]')
        expect(page).to have_button('Submit')
      end

      context 'when I fill in the form with valid data and click "Submit"' do
        let(:activity) { 'Weight Lifting' }
        let(:year) { '2022' }
        let(:month) { 'January' }
        let(:day) { '1' }
        let(:hours) { '17' }
        let(:minutes) { '00' }

        let(:new_event) do
          Event.new(
            id: '1',
            attributes: {
              user_id: friend.id,
              gym_membership_id: current_user_gym_membership.id,
              date_time: 'Sat, 01 Jan 2022 17:00:00 +0000',
              activity: activity
            }
          )
        end

        let(:create_event_params) do
          {
            'user_id' => '10',
            'gym_membership_id' => '1',
            'activity' => 'Weight Lifting',
            'date_time' => 'Sat, 01 Jan 2022 17:00:00 +0000'
          }
        end

        before do
          allow(EventFacade).to receive(:create_event).with(create_event_params).and_return(new_event)
          allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return([friend])
          allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return([current_user_gym_membership])
          allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return([new_event])

          fill_in 'activity', with: activity
          select year, from: 'date[when(1i)]'
          select month, from: 'date[when(2i)]'
          select day, from: 'date[when(3i)]'
          select hours, from: 'time[start_time(4i)]'
          select minutes, from: 'time[start_time(5i)]'

          click_button 'Submit'
        end

        it 'redirects me to the User Dashboard page' do
          expect(page).to have_current_path(dashboard_index_path, ignore_query: true)
        end

        it 'displays a success flash message' do
          expect(page).to have_content('Workout created! Now go get your swole on!')
        end

        it 'displays the new workout event' do
          within '#upcoming-workouts' do
            expect(page).to have_content(new_event.activity)
          end
        end
      end
    end
  end
end
