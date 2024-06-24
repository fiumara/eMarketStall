require "test_helper"

class GestioneCampagneControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gestione_campagne_index_url
    assert_response :success
  end
end
