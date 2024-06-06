require "test_helper"

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  test "should get select" do
    get languages_select_url
    assert_response :success
  end
end
