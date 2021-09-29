shared_context 'logged in as authenticated user' do
  let(:user) do
    User.new(
      id: 1,
      attributes: {
        email: '123@test.com',
        full_name: 'Joe Shmoe',
        google_id: 789,
        google_image_url: 'pretty face',
        zip_code: '80227',
        summary: 'Muy guesta gimnasios',
        goal: 'Gain Muscle',
        availability_morning: true,
        availability_afternoon: true,
        availability_evening: false
      }
    )
  end

  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end
end
