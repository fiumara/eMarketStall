require "test_helper"

class StatisticheControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get statistiche_show_url
    assert_response :success
  end
end
