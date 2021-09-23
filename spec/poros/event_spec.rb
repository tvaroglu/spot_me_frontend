require 'rails_helper'

RSpec.describe Event, type: :poro do
  it 'can initialize from event params' do
    id = '1'
    user_id = 1
    gym_membership_id = 1
    date_time = '2021-09-22T21:41:28.289Z'
    activity = 'Bodybuilding'

    event_params = {
      id: id,
      attributes: {
        user_id: user_id,
        gym_membership_id: gym_membership_id,
        date_time: date_time,
        activity: activity
      }
    }

    event = Event.new(event_params)

    expect(event).to be_an_instance_of(Event)
    expect(event.id).to eq(id)
    expect(event.id).to be_a String
    expect(event.user_id).to eq(user_id)
    expect(event.user_id).to be_an Integer
    expect(event.gym_membership_id).to eq(gym_membership_id)
    expect(event.gym_membership_id).to be_an Integer
    expect(event.date_time).to eq(date_time.to_datetime.strftime('%A, %b %d, %Y %l:%M%P'))
    expect(event.date_time).to be_a String
    expect(event.activity).to eq(activity)
    expect(event.activity).to be_a String
  end

  describe 'instance methods' do
    describe '#format_date' do
      it 'returns the formatted date as [this format]' do
        id = '1'
        user_id = 1
        gym_membership_id = 1
        date_time = '2021-09-22T21:41:28.289Z'
        activity = 'Bodybuilding'

        event_params = {
          id: id,
          attributes: {
            user_id: user_id,
            gym_membership_id: gym_membership_id,
            date_time: date_time,
            activity: activity
          }
        }

        event = Event.new(event_params)
        date_time = '2021-09-22T21:41:28.289Z'

        expect(event.format_date(date_time)).to eq('Wednesday, Sep 22, 2021  9:41pm')
      end
    end
  end
end
