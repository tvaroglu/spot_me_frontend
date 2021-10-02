class Event
  attr_reader :id,
              :user_id,
              :gym_membership_id,
              :date_time,
              :activity,
              :invitee_name,
              :role

  def initialize(data)
    @id = data[:id]
    @user_id = data[:attributes][:user_id]
    @gym_membership_id = data[:attributes][:gym_membership_id]
    @date_time = data[:attributes][:date_time]
    @activity = data[:attributes][:activity]
    @invitee_name = data[:meta][:friend_name]
    @role = data[:meta][:friend_role]
  end

  # TODO: Update method to handle different timezones
  # Returns the date in the format of 'Wednesday, Sep 22, 2021 9:41pm'
  def format_date
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S').strftime('%A, %b %d, %Y%l:%M%P')
  end

  # TODO: Update method to handle different timezones
  # Returns the date in the format of 'Wed 09/22/21 9:41pm'
  def format_date_short
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S').strftime('%a %m/%d/%y%l:%M%P')
  end
end
