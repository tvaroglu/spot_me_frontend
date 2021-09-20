class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.user_stub
    User.new({
      id: 31,
      email: 'ron_hermiston@schinner.net',
      google_id: '123456789102345678910',
      google_image_url: 'https://robohash.org/doloribusutmagni.png?size=300x300&set=set1',
      zip_code: '55919',
      summary: 'The secret to humor is surprise.',
      goal: 'Gain Weight',
      availability_morning: false,
      availability_afternoon: true,
      availability_evening: true,
      full_name: 'Alvaro Stanton'
      })
  end
end
