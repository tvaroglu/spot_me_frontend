class BackEndFacade
  class << self
    def get_user(google_id)
      user = BackEndService.get_user(google_id)
      user[:data].present? ? User.new(user[:data]) : nil
    end

    def create_user(params)
      BackEndService.create_user(params)
    end

    def get_user_friends(user_id)
      friends = BackEndService.get_friends(user_id)
      friends[:data].map do |friend|
        User.new(friend[:attributes])
      end
    end

    def get_user_gyms(user_id)
      gyms = BackEndService.get_gyms(user_id)
      # require "pry"; binding.pry
      gyms[:data].map do |gym|
        UserGym.new(gym[:attributes])
      end
    end

    # def searched_gyms(location)
    #   gyms = BackEndService.gyms_near_user(location)
    #   gyms[:businesses].map do |gym|
    #     YelpGym.new(gym)
    #   end
    # end

    def get_user_events(user_id)
      events = BackEndService.get_events(user_id)
      events[:data].map do |event|
        UserEvent.new(event)
      end
    end
  end
end
