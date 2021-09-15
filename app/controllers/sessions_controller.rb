class SessionsController < ApplicationController
  def create
    require "pry"; binding.pry
    new_user = UserService.new(params[:something])
    BackEndFacade.send_request(new_user)
      # Faraday.post('/api/vi/users/authenticate').with body(new_user)
  end
end
