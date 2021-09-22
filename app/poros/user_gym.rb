class UserGym
  attr_reader :user_id, :yelp_gym_id, :gym_name

  def initialize(info)
    @user_id = info[:user_id]
    @yelp_gym_id = info[:yelp_gym_id]
    @gym_name = info[:gym_name]
  end
end
