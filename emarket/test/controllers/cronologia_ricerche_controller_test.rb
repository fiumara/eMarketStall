require "test_helper"

class CronologiaRicercheControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cronologia_ricerche_index_url
    assert_response :success
  end
end
