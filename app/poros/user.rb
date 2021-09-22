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

  def initialize(data)
    @id = data[:id]
    return unless data[:attributes]

    @email = data[:attributes][:email]
    @full_name = data[:attributes][:full_name]
    @google_id = data[:attributes][:google_id]
    @google_image_url = data[:attributes][:google_image_url]
    @zip_code = data[:attributes][:zip_code]
    @summary = data[:attributes][:summary]
    @goal = data[:attributes][:goal]
    @availability_morning = data[:attributes][:availability_morning]
    @availability_afternoon = data[:attributes][:availability_afternoon]
    @availability_evening = data[:attributes][:availability_evening]
  end
end
