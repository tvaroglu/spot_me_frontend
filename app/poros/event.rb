class Event
  include Formatable
  attr_reader :id,
              :user_id,
              :gym_membership_id,
              :date_time,
              :activity,
              :friend_name,
              :friend_role,
              :gym_name,
              :yelp_gym_id

  def initialize(data)
    @id = data[:id]
    @user_id = data[:attributes][:user_id]
    @gym_membership_id = data[:attributes][:gym_membership_id]
    @date_time = data[:attributes][:date_time]
    @activity = data[:attributes][:activity]
    @friend_name = data[:meta][:friend_name]
    @friend_role = data[:meta][:friend_role]
    @gym_name = data[:meta][:gym_name]
    @yelp_gym_id = data[:meta][:yelp_gym_id]
  end
end
