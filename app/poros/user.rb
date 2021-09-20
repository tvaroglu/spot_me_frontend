class User
  attr_reader :id,
              :email,
              :full_name,
              :google_id,
              :google_image_url,
              :zip_code,
              :summary,
              :goal,
              :availability_morning,
              :availability_afternoon,
              :availability_evening

  def initialize(user_params)
    @id = user_params[:id]
    if user_params[:attributes]
      @email = user_params[:attributes][:email]
      @full_name = user_params[:attributes][:full_name]
      @google_id = user_params[:attributes][:google_id]
      @google_image_url = user_params[:attributes][:google_image_url]
      @zip_code = user_params[:attributes][:zip_code]
      @summary = user_params[:attributes][:summary]
      @goal = user_params[:attributes][:goal]
      @availability_morning = user_params[:attributes][:availability_morning]
      @availability_afternoon = user_params[:attributes][:availability_afternoon]
      @availability_evening = user_params[:attributes][:availability_evening]
    end
  end
end
