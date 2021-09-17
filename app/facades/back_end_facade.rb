class BackEndFacade
  class << self
    def get_user(google_id)
      user = BackEndService.get_user(google_id)
      user[:data].present? ? User.new(user[:data]) : nil
    end

    def create_user(params)
      BackEndService.create_user(params)
    end
  end
end
