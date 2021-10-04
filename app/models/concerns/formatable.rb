module Formatable
  def format_city_state_zip(data)
    city = data[:city]
    state_abbr = data[:state]
    zip_code = data[:zip_code]

    "#{city}, #{state_abbr} #{zip_code}"
  end

  # TODO: Update method to handle different timezones
  # Returns the date in the format of 'Wednesday, Sep 22, 2021 9:41pm'
  def format_date
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S')
            .strftime('%A, %b %d, %Y%l:%M%P')
  end

  # TODO: Update method to handle different timezones
  # Returns the date in the format of 'Wed 09/22/21- 9:41pm'
  def format_date_short
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S')
            .strftime('%a %m/%d/%y-%l:%M%P')
  end

  def date
    DateTime.strptime(date_time, '%Y-%m-%dT%H:%M:%S').strftime('%a %m/%d/%y')
  end
end
