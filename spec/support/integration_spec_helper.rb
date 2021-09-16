module IntegrationSpecHelper
  def login_with_oauth(service = :google_oauth2)
    click_on 'Sign in with Google'
    # visit "/auth/#{service}"
  end
end
