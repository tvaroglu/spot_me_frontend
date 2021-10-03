module Convertable
  def format_city_state_zip(data)
    city = data[:attributes][:address_details][:city]
    state_abbr = data[:attributes][:address_details][:state]
    zip_code = data[:attributes][:address_details][:zip_code]

    "#{city}, #{state_abbr} #{zip_code}"
  end
end
