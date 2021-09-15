class SessionsController < ApplicationController
  def new; end

  def create
    require "pry"; binding.pry
    BackEndFacade.authenticate_user('/api/v1/users', params)
  end
end
