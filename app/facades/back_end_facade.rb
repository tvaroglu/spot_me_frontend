class BackEndFacade
  class << self
    def get_user(google_id)
      user = BackEndService.get_user(google_id)
      user[:data].present? ? User.new(user[:data]) : nil
    end

    def create_user(params)
      BackEndService.create_user(params)
    end

    def update_user(params, user_id)
      BackEndService.update_user(params, user_id)
    end

    def get_user_friends(user_id)
      friends = BackEndService.get_friends(user_id)
      if friends[:data]
        friends[:data].map do |friend|
          User.new(friend[:attributes])
        end
      end
    end

    def get_user_gyms(user_id)
      gyms = BackEndService.get_gyms(user_id)
      gyms[:data].map { |gym| UserGym.new(gym[:attributes]) } if gyms[:data]
    end

    def get_user_events(user_id)
      events = BackEndService.get_events(user_id)
      events[:data].map { |event| UserEvent.new(event) } if events[:data]
    end

    # def searched_gyms(location)
    #   gyms = BackEndService.gyms_near_user(location)
    #   gyms[:businesses].map do |gym|
    #     YelpGym.new(gym)
    #   end
    # end

    def get_gyms_near_user(zip_code)
      gyms = BackEndService.gyms_near_user(zip_code)
      gyms[:data].map do |gym|
        YelpGym.new(gym) if gyms[:data]
      end
    end
  end
end
