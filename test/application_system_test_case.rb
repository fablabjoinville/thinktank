require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def login_as(user)
    visit new_user_session_url

    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on "Entrar"
  end
end
