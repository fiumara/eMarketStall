require "test_helper"

class ListaDesideriControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lista_desideri_index_url
    assert_response :success
  end
end
