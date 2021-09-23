class Event
  attr_reader :id, :user_id, :gym_membership_id, :date_time, :activity

  def initialize(info)
    @id = info[:id]
    @user_id = info[:attributes][:user_id]
    @gym_membership_id = info[:attributes][:gym_membership_id]
    @date_time = format_date(info[:attributes][:date_time])
    @activity = info[:attributes][:activity]
  end

  def format_date(date)
    date.to_datetime.strftime('%A, %b %d, %Y %l:%M%P')
  end
end
