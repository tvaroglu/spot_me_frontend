class FriendshipFacade
  def self.get_friends(user_id)
    friends = FriendshipService.get_friends(user_id)
    return [] unless friends[:data]

    friends[:data].map { |friend| User.new(friend) }
  end

  def self.get_followers(user_id)
    followers = FriendshipService.get_followers(user_id)
    return [] unless followers[:data]

    followers[:data].map { |follower| User.new(follower) }
  end

  def self.get_friends_at_gym(yelp_gym_id, current_user_id)
    friends = FriendshipService.get_friends_at_gym(yelp_gym_id, current_user_id)
    return [] unless friends[:data]

    friends[:data].map { |friend| User.new(friend) }
  end

  def self.get_non_friends_at_gym(params)
    non_friends = FriendshipService.get_non_friends_at_gym(params)
    return [] unless non_friends[:data]

    non_friends[:data].map { |non_friend| User.new(non_friend) }
  end

  def self.add_friend(params)
    json = FriendshipService.add_friend(params)
    return unless json[:data]

    User.new(json[:data])
  end

  def self.delete_friend(params)
    FriendshipService.delete_friend(params)
  end
end
