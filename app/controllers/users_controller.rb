class UsersController < ApplicationController
  def new; end

  def create
    require "pry"; binding.pry
    BackEndFacade.send_request('/api/v1/users', params)
  end
end
