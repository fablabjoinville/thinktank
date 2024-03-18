require "application_system_test_case"

class TeamsTest < ApplicationSystemTestCase

  test 'visit the teams index' do
    login_as(create(:user, email: "facilitator@example.com"))

    visit teams_url

    assert_selector "#page_title", text: "Equipes"
    assert Team.count, 0
  end
end
