require "test_helper"

class ArchivioOrdiniControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get archivio_ordini_index_url
    assert_response :success
  end
end
