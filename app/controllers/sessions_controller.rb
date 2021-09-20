class SessionsController < ApplicationController
  # If you're using a strategy that POSTs during callback,
  # you'll need to skip the authenticity token check
  # for the callback action only:
  # skip_before_action :verify_authenticity_token, only: :create

  def create
    found_user = BackEndFacade.get_user(helper_hash[:google_id])
    if found_user.present?
      session[:google_token] = helper_hash[:google_token]
      session[:google_id] = helper_hash[:google_id]
      redirect_to dashboard_path(found_user.id)
    else
      redirect_to registration_path(helper_hash)
    end
  end

  def destroy
    session[:google_token] = nil
    session[:google_id] = nil
    reset_session
    flash[:alert] = 'You are now logged out, please come back soon!'
    redirect_to root_path
  end

  private

  def helper_hash
    {
      google_id: auth_hash['uid'],
      email: auth_hash['info']['email'],
      full_name: auth_hash['info']['name'],
      google_image_url: auth_hash['info']['image'],
      google_token: auth_hash['credentials']['token']
    }
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
