require 'rails_helper'

describe EventFacade, type: :facade do
  describe '.get_upcoming_events' do
    context 'when the user has events' do
      it "can return an array of the user's workouts", :vcr do
        events = EventFacade.get_upcoming_events(1)

        expect(events[0]).to be_an_instance_of(Event)
        expect(events).not_to be_empty
      end
    end

    context 'when the user does not have any events' do
      it 'can return an empty array', :vcr do
        events = EventFacade.get_upcoming_events(2)

        expect(events).to be_empty
      end
    end
  end
end
