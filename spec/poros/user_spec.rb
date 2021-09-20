require 'rails_helper'

RSpec.describe User do
  it 'can initialize from user params' do
    user_params = {
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
    }

    user = User.new(user_params)

    expect(user).to be_an_instance_of(User)
    expect(user.id).to eq(1)
    expect(user.email).to eq('123@test.com')
    expect(user.full_name).to eq('Joe Shmoe')
    expect(user.google_id).to eq(789)
    expect(user.google_image_url).to eq('pretty face')
    expect(user.zip_code).to eq('80227')
    expect(user.summary).to eq('Muy guesta gimnasios')
    expect(user.goal).to eq('Gain Weight')
    expect(user.availability_morning).to eq(true)
    expect(user.availability_afternoon).to eq(true)
    expect(user.availability_evening).to eq(false)
  end
end
