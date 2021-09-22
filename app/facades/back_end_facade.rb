class BackEndFacade
  class << self
    def get_user(google_id)
      user = BackEndService.get_user(google_id)
      return unless user[:data]

      User.new(user[:data])
    end

    def create_user(params)
      BackEndService.create_user(params)
    end

    def delete_event(params)
      BackEndService.delete_event(params)
    end

    def get_user_friends(user_id)
      friends = BackEndService.get_friends(user_id)
      return Array.new unless friends[:data]

      friends[:data].map { |friend| User.new(friend[:attributes]) }
    end

    def get_user_gyms(user_id)
      gyms = BackEndService.get_gyms(user_id)
      return Array.new unless gyms[:data]

      gyms[:data].map { |gym| UserGym.new(gym[:attributes]) }
    end

    def get_user_events(user_id)
      events = BackEndService.get_events(user_id)
      return Array.new unless events[:data]

      events[:data].map { |event| UserEvent.new(event) }
    end

    def get_gyms_near_user(zip_code)
      gyms = BackEndService.gyms_near_user(zip_code)
      return Array.new unless gyms[:data]

      gyms[:data].map { |gym| YelpGym.new(gym) }
    end
  end
end
