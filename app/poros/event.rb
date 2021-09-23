class Event
  attr_reader :id, :user_id, :gym_membership_id, :date_time, :activity

  def initialize(data)
    @id                = data[:id]
    @user_id           = data[:attributes][:user_id]
    @gym_membership_id = data[:attributes][:gym_membership_id]
    @date_time         = format_date(data[:attributes][:date_time])
    @activity          = data[:attributes][:activity]
  end

  def format_date(date)
    date.to_datetime.strftime('%A, %b %d, %Y %l:%M%P')
  end
end
