require "test_helper"

class ReturnRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get return_requests_index_url
    assert_response :success
  end

  test "should get new" do
    get return_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get return_requests_create_url
    assert_response :success
  end

  test "should get show" do
    get return_requests_show_url
    assert_response :success
  end

  test "should get update" do
    get return_requests_update_url
    assert_response :success
  end
end
