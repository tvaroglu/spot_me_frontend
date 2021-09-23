class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.user_stub
    User.new(
      id: 1,
      attributes: {
        email: '123@test.com',
        full_name: 'Joe Shmoe',
        google_id: 789,
        google_image_url: 'pretty face',
        zip_code: '80227',
        summary: 'Muy guesta gimnasios',
        goal: 'Gain Weight',
        availability_morning: true,
        availability_afternoon: true,
        availability_evening: false
      }
    )
  end
end
