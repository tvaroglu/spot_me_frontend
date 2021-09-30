class Event
  attr_reader :id, :user_id, :invitee_name, :gym_membership_id, :date_time, :activity

  def initialize(data)
    @id                = data[:id]
    @user_id           = data[:attributes][:user_id]
    @invitee_name      = data[:relationships][:user][:meta][:full_name]
    @gym_membership_id = data[:attributes][:gym_membership_id]
    @date_time         = data[:attributes][:date_time]
    @activity          = data[:attributes][:activity]
  end

  def format_date
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S.000').strftime('%A, %b %d, %Y %l:%M%P')
  end

  def format_date_short
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S.000').strftime('%a %m/%d/%y %l:%M%P')
  end
end
