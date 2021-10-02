shared_context 'experienced user' do
  let(:user1) do
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

  let(:user2) do
    User.new(
      id: 20,
      attributes: {
        email: '234@test.com',
        full_name: 'John Doe',
        google_id: 234,
        google_image_url: 'pretty face',
        zip_code: '80227',
        summary: 'Muy guesta gimnasios',
        goal: 'Gain Weight',
        availability_morning: true,
        availability_afternoon: false,
        availability_evening: true
      }
    )
  end

  let(:user3) do
    User.new(
      id: 30,
      attributes: {
        email: '345@test.com',
        full_name: 'Jane Doe',
        google_id: 345,
        google_image_url: 'pretty face',
        zip_code: '80227',
        summary: 'Muy guesta gimnasios',
        goal: 'Gain Weight',
        availability_morning: false,
        availability_afternoon: false,
        availability_evening: true
      }
    )
  end

  let(:gym_membership1) do
    GymMembership.new(
      id: '1',
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: 'lex65fkcol5gfq89rymmd2',
        gym_name: 'Kling-Wilkinson'
      }
    )
  end

  let(:gym_membership2) do
    GymMembership.new(
      id: '7',
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: '6x10s0lbnry4ivkzcjpilk',
        gym_name: 'Konopelski, Lowe and Haley'
      }
    )
  end

  let(:gym_membership3) do
    GymMembership.new(
      id: '17',
      type: 'gym_membership',
      attributes: {
        user_id: 1,
        yelp_gym_id: 'wxaw9m796t6wdnsk53uieh',
        gym_name: 'Funk LLC'
      }
    )
  end

  let(:gym_membership4) do
    GymMembership.new(
      id: '20',
      type: 'gym_membership',
      attributes: {
        user_id: user1.id,
        yelp_gym_id: 'wxaw9m796t6wdnsk53uieh',
        gym_name: 'Funk LLC'
      }
    )
  end

  let(:gym1) do
    Gym.new(
      id: 'lex65fkcol5gfq89rymmd2',
      type: 'gym',
      attributes: {
        name: 'Kling-Wilkinson',
        address: 'address3',
        phone: '345-345-3456',
        address_details: {
          address1: "431 Pierre St",
          address2: nil,
          address3: '',
          city: 'Boulder',
          state: 'CO',
          zip_code: '80304'
        }
      }
    )
  end

  let(:gym2) do
    Gym.new(
      id: '6x10s0lbnry4ivkzcjpilk',
      type: 'gym',
      attributes: {
        name: 'Konopelski, Lowe and Haley',
        address: 'address2',
        phone: '234-234-2345',
        address_details: {
          address1: "432 Pierre St",
          address2: nil,
          address3: '',
          city: 'Boulder',
          state: 'CO',
          zip_code: '80305'
        }
      }
    )
  end

  let(:gym3) do
    Gym.new(
      id: 'wxaw9m796t6wdnsk53uieh',
      type: 'gym',
      attributes: {
        name: 'Funk LLC',
        address: 'address1',
        phone: '123-123-1234',
        address_details: {
          address1: "433 Pierre St",
          address2: nil,
          address3: '',
          city: 'Boulder',
          state: 'CO',
          zip_code: '80306'
        }
      }
    )
  end

  let(:event1) do
    Event.new(
      id: '1',
      attributes: {
        user_id: 20,
        gym_membership_id: 1,
        activity: 'Bodybuilding',
        date_time: '2022-07-22T21:41:28.000Z'
      },
      meta: {
        friend_name: user2.full_name,
        friend_role: 'invited'
      }
    )
  end

  let(:event2) do
    Event.new(
      id: '2',
      attributes: {
        user_id: 30,
        gym_membership_id: 2,
        date_time: '2022-08-22T21:41:28.000Z',
        activity: 'Running'
      },
      meta: {
        friend_name: user3.full_name,
        friend_role: 'invited'
      }
    )
  end

  let(:event3) do
    Event.new(
      id: '3',
      attributes: {
        user_id: 20,
        gym_membership_id: 3,
        date_time: '2022-09-22T21:41:28.000Z',
        activity: 'Stretching'
      },
      meta: {
        friend_name: user2.full_name,
        friend_role: 'invited'
      }
    )
  end

  let(:event4) do
    Event.new(
      id: '4',
      attributes: {
        user_id: user.id,
        gym_membership_id: gym_membership4.id,
        date_time: '2022-09-22T21:41:28.000Z',
        activity: 'Stretching'
      },
      meta: {
        friend_name: user1.full_name,
        friend_role: 'host'
      }
    )
  end

  let(:user_friends) { [user1, user2, user3] }
  let(:user_gym_memberships) { [gym_membership1, gym_membership2, gym_membership3] }
  let(:gyms_near_user) { [gym1, gym2, gym3] }
  let(:user_events) { [event1, event2, event3, event4] }

  before do
    allow(FriendshipFacade).to receive(:get_friends).with(user.id).and_return(user_friends)
    allow(GymMembershipFacade).to receive(:get_gym_memberships).with(user.id).and_return(user_gym_memberships)
    allow(EventFacade).to receive(:get_upcoming_events).with(user.id).and_return(user_events)
    allow(GymFacade).to receive(:get_gyms_near_user).with(user.zip_code).and_return(gyms_near_user)
  end
end
