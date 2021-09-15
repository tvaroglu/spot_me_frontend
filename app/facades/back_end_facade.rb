class BackEndFacade
  class << self
    def authenticate_user(endpoint, params)
      BackEndService.send_request(endpoint, params)
    end
  end
end
