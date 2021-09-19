class UserEvent
  attr_reader :id, :user_id, :gym_id, :date_time, :activity

  def initialize(info)
    @id = info[:id]
    @user_id = info[:attributes][:user_id]
    @gym_id = info[:attributes][:gym_id]
    @date_time = info[:attributes][:date_time]
    @activity = info[:attributes][:activity]
  end
end
