module IntegrationSpecHelper
  def login_with_oauth(_service = :google_oauth2)
    if page.has_link?('Sign in with Google')
      page.click_link('Sign in with Google', match: :first)
    end
  end
end
