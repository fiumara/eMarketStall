require "test_helper"

class OrdiniNegoziControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ordini_negozi_index_url
    assert_response :success
  end

  test "should get show" do
    get ordini_negozi_show_url
    assert_response :success
  end

  test "should get update" do
    get ordini_negozi_update_url
    assert_response :success
  end
end
