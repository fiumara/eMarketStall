require "test_helper"

class MessaggiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get messaggi_index_url
    assert_response :success
  end
end
