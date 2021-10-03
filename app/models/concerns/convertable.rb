module Convertable
  def format_city_state_zip(data)
    city = data[:city]
    state_abbr = data[:state]
    zip_code = data[:zip_code]

    "#{city}, #{state_abbr} #{zip_code}"
  end
end
