require 'rails_helper'

describe Event, type: :poro do
  it 'can initialize from event params' do
    id = '1'
    user_id = 1
    gym_membership_id = 1
    date_time = '2021-09-22T21:41:28.000Z'
    activity = 'Bodybuilding'
    friend_name = 'Jimmy'
    friend_role = 'invited'

    event_params = {
      id: id,
      attributes: {
        user_id: user_id,
        gym_membership_id: gym_membership_id,
        date_time: date_time,
        activity: activity
      },
      meta: {
        friend_name: 'Jimmy',
        friend_role: 'invited'
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
    expect(event.date_time).to eq(date_time)
    expect(event.date_time).to be_a String
    expect(event.activity).to eq(activity)
    expect(event.activity).to be_a String
    expect(event.friend_name).to eq(friend_name)
    expect(event.friend_name).to be_a String
    expect(event.friend_role).to eq(friend_role)
    expect(event.friend_role).to be_a String
  end

  describe 'instance methods' do
    describe '#format_date' do
      it 'returns the formatted date as "Wednesday, Sep 22, 2021  9:41pm"' do
        id = '1'
        user_id = 1
        gym_membership_id = 1
        date_time = '2021-09-22T21:41:28.000Z'
        activity = 'Bodybuilding'

        event_params = {
          id: id,
          attributes: {
            user_id: user_id,
            gym_membership_id: gym_membership_id,
            date_time: date_time,
            activity: activity
          },
          meta: {
            friend_name: 'Jimmy',
            friend_role: 'invited'
          }
        }

        event = Event.new(event_params)
        date_time = '2021-09-22T21:41:28.000Z'

        expect(event.format_date).to eq('Wednesday, Sep 22, 2021 9:41pm')
      end
    end

    describe '#format_date_short' do
      it 'returns the formatted date as "Wednesday, Sep 22, 2021 9:41pm"' do
        id = '1'
        user_id = 1
        gym_membership_id = 1
        date_time = '2021-09-22T21:41:28.000Z'
        activity = 'Bodybuilding'

        event_params = {
          id: id,
          attributes: {
            user_id: user_id,
            gym_membership_id: gym_membership_id,
            date_time: date_time,
            activity: activity
          },
          meta: {
            friend_name: 'Jimmy',
            friend_role: 'invited'
          }
        }

        event = Event.new(event_params)
        date_time = '2021-09-22T21:41:28.000Z'

        expect(event.format_date_short).to eq('Wed 09/22/21 9:41pm')
      end
    end

    describe '#date' do
      it 'returns the formatted date as "Wednesday, Sep 22, 2021 9:41pm"' do
        id = '1'
        user_id = 1
        gym_membership_id = 1
        date_time = '2021-09-22T21:41:28.000Z'
        activity = 'Bodybuilding'

        event_params = {
          id: id,
          attributes: {
            user_id: user_id,
            gym_membership_id: gym_membership_id,
            date_time: date_time,
            activity: activity
          },
          meta: {
            friend_name: 'Jimmy',
            friend_role: 'invited'
          }
        }

        event = Event.new(event_params)
        date_time = '2021-09-22T21:41:28.000Z'

        expect(event.date).to eq('Wed 09/22/21')
      end
    end
  end
end
