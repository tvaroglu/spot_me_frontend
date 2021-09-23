class BackEndFacade
  class << self
    def get_user(google_id)
      user = BackEndService.get_user(google_id)
      return unless user[:data]

      User.new(user[:data])
    end

    def get_profile_user(user_id)
      user = BackEndService.get_profile_user(user_id)
      return unless user[:data]

      User.new(user[:data])
    end

    def create_user(params)
      BackEndService.create_user(params)
    end

    def create_event(params)
      json = BackEndService.create_event(params)
      return unless json[:data]

      UserEvent.new(json[:data])
    end

    def delete_event(params)
      BackEndService.delete_event(params)
    end

    def get_gym_membership(params)
      response = BackEndService.get_gym_memberships(params[:user_id])
      return unless response[:data]

      gym_memberships = response[:data].map { |data| GymMembership.new(data) }
      gym_memberships.select do |gym_membership|
        gym_membership.yelp_gym_id == params[:yelp_gym_id]
      end.first
    end

    def create_gym_membership(gym_membership_params)
      BackEndService.post_gym_membership(gym_membership_params)
    end

    def delete_gym_membership(params)
      BackEndService.delete_gym_membership(params)
    end

    def get_user_friends(user_id)
      friends = BackEndService.get_friends(user_id)
      return Array.new unless friends[:data]

      friends[:data].map { |friend| User.new(friend[:attributes]) }
    end

    def get_user_gyms(user_id)
      gyms = BackEndService.get_gyms(user_id)
      return Array.new unless gyms[:data]

      gyms[:data].map { |gym| GymMembership.new(gym[:attributes]) }
    end

    def get_gyms_near_user(zip_code)
      gyms = BackEndService.gyms_near_user(zip_code)
      return Array.new unless gyms[:data]

      gyms[:data].map { |gym| YelpGym.new(gym) }
    end

    def get_user_events(user_id)
      events = BackEndService.get_events(user_id)
      return Array.new unless events[:data]

      events[:data].map { |event| UserEvent.new(event) }
    end

    def get_selected_gym(yelp_gym_id)
      gym = BackEndService.get_one_gym(yelp_gym_id)
      return unless gym[:data]

      YelpGym.new(gym[:data])
    end

    def get_gym_users(yelp_api_key)
      users = BackEndService.get_gym_users(yelp_api_key)

      if users[:data]
        users[:data].map do |user|
          User.new(user)
        end
      end
    end

    def get_gym_users_count(yelp_api_key)
      users = BackEndService.get_gym_users(yelp_api_key)

      GymUserCount.new(users[:meta]) if users[:meta]
    end

    def get_friends_at_gym(yelp_gym_id, current_user_id)
      friends = BackEndService.get_friends_at_gym(yelp_gym_id, current_user_id)

      if friends[:data]
        friends[:data].map do |friend|
          User.new(friend)
        end
      end
    end

    def get_non_friends_at_gym(params)
      non_friends = BackEndService.get_non_friends_at_gym(params)
      return unless non_friends[:data]

      non_friends[:data].map { |friend| User.new(non_friend) }
    end
  end
end
