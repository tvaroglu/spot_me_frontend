require 'rails_helper'

describe EventFacade, type: :facade do
  describe '.get_upcoming_events' do
    context 'when the user has upcoming events' do
      it "can return an array of the user's workouts", :vcr do
        events = EventFacade.get_upcoming_events(1)

        expect(events[0]).to be_an_instance_of(Event)
        expect(events).not_to be_empty
      end
    end

    context 'when the user does not have any events' do
      it 'can return an empty array', :vcr do
        events = EventFacade.get_upcoming_events(11)

        expect(events).to be_empty
      end
    end
  end

  describe '.get_past_events' do
    context 'when the user has past events' do
      it "can return an array of the user's workouts", :vcr do
        events = EventFacade.get_past_events(1)

        expect(events[0]).to be_an_instance_of(Event)
        expect(events).not_to be_empty
      end
    end

    context 'when the user does not have any events' do
      it 'can return an empty array', :vcr do
        events = EventFacade.get_past_events(11)

        expect(events).to be_empty
      end
    end
  end

  describe '.create_event' do
    it 'returns a hash with the gym membership details' do
      friend_id = 10
      user_gym_membership_id = 42
      activity = 'c2jzsndq8brvn9fbckeec2'
      date_time = 'Planet Fitness'
      request_params = {
        user_id: friend_id,
        gym_membership_id: user_gym_membership_id,
        activity: activity,
        date_time: date_time
      }

      allow(EventService).to receive(:create_event).with(request_params).and_return(true)

      expect(EventFacade.create_event(request_params)).to eq(true)
    end
  end

  describe '.delete_event' do
    it 'returns a hash with the gym membership details' do
      friend_id = 10
      user_gym_membership_id = 42
      event_id = 32
      path_params = {
        user_id: friend_id,
        gym_membership_id: user_gym_membership_id,
        id: event_id
      }

      allow(EventService).to receive(:delete_event).with(path_params).and_return(true)

      expect(EventFacade.delete_event(path_params)).to eq(true)
    end
  end
end
