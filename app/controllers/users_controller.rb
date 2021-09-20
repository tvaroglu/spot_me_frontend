class UsersController < ApplicationController
  def new; end

  def create
    BackEndFacade.create_user(params)
    found_user = BackEndFacade.get_user(params[:google_id])
    # if params[:google_token]
    if found_user.present?
      session[:google_token] = params[:google_token]
      session[:google_id] = params[:google_id]
      redirect_to dashboard_path(found_user.id)
      # redirect_to dashboard_path(params[:google_id])
    else
      flash[:error] = "Couldn't create your account, please try again."
      redirect_to root_path
    end
  end

  def dashboard
    @user_friends = BackEndFacade.get_user_friends(current_user.id)
    @user_gyms = BackEndFacade.get_user_gyms(current_user.id)
    @user_events = BackEndFacade.get_user_events(current_user.id)
    # placeholder for sprint
    @user = User.new({
        :id=>31,
        :email=>"ron_hermiston@schinner.net",
        :google_id=>"123456789102345678910",
        :google_image_url=>"https://robohash.org/doloribusutmagni.png?size=300x300&set=set1",
        :zip_code=>"55919",
        :summary=>"The secret to humor is surprise.",
        :goal=>"Gain Weight",
        :availability_morning=>false,
        :availability_afternoon=>true,
        :availability_evening=>true,
        :full_name=>"Alvaro Stanton"
        })
  end

  def profile
    # placeholder for sprint
    @user = User.new({
        :id=>31,
        :email=>"ron_hermiston@schinner.net",
        :google_id=>"123456789102345678910",
        :google_image_url=>"https://robohash.org/doloribusutmagni.png?size=300x300&set=set1",
        :zip_code=>"55919",
        :summary=>"The secret to humor is surprise.",
        :goal=>"Gain Weight",
        :availability_morning=>false,
        :availability_afternoon=>true,
        :availability_evening=>true,
        :full_name=>"Alvaro Stanton"
        })
  end
end
