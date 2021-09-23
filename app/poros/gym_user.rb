class GymUser
  attr_reader :availability_afternoon,
               :availability_afternoon,
               :availability_evening,
               :email,
               :full_name,
               :goal,
               :google_id,
               :google_image_url,
               :summary,
               :zip_code,
               :id

  def initialize(info)
    @availability_morning = info[:attributes][:availability_morning]
    @availability_afternoon = info[:attributes][:availability_afternoon]
    @availability_evening = info[:attributes][:availability_evening]
    @email = info[:attributes][:email]
    @full_name = info[:attributes][:full_name]
    @goal = info[:attributes][:goal]
    @google_id = info[:attributes][:google_id]
    @google_image_url = info[:attributes][:google_image_url]
    @summary = info[:attributes][:summary]
    @zip_code = info[:attributes][:zip_code]
    @id = info[:id]
  end
end
