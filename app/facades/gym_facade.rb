class GymFacade
  def self.get_gyms_near_user(zip_code)
    gyms = GymService.get_gyms_near_user(zip_code)
    return [] unless gyms[:data]

    gyms[:data].map { |gym| Gym.new(gym) }
  end

  def self.get_gym(yelp_gym_id)
    gym = GymService.get_gym(yelp_gym_id)
    return unless gym[:data]

    Gym.new(gym[:data])
  end

  def self.get_gym_users(yelp_api_key)
    users = GymService.get_gym_users(yelp_api_key)
    return [] unless users[:data]

    users[:data].map { |user| User.new(user) }
  end

  def self.get_gym_users_count(yelp_api_key)
    users = GymService.get_gym_users(yelp_api_key)
    return unless users[:meta]

    GymUserCount.new(users[:meta])
  end
end
