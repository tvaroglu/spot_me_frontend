class UserFacade
  def self.get_user(google_id)
    user = UserService.get_user(google_id)
    return unless user[:data]

    User.new(user[:data])
  end

  def self.get_profile_user(user_id)
    user = UserService.get_profile_user(user_id)
    return unless user[:data]

    User.new(user[:data])
  end

  def self.create_user(params)
    UserService.create_user(params)
  end

  def self.update_user(params, user_id)
    UserService.update_user(params, user_id)
    user = UserService.get_profile_user(user_id)
    return unless user[:data]

    User.new(user[:data])
  end
end
