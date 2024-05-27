require "test_helper"

class AcquirentesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acquirente = acquirentes(:one)
  end

  test "should get index" do
    get acquirentes_url
    assert_response :success
  end

  test "should get new" do
    get new_acquirente_url
    assert_response :success
  end

  test "should create acquirente" do
    assert_difference('Acquirente.count') do
      post acquirentes_url, params: { acquirente: {  } }
    end

    assert_redirected_to acquirente_url(Acquirente.last)
  end

  test "should show acquirente" do
    get acquirente_url(@acquirente)
    assert_response :success
  end

  test "should get edit" do
    get edit_acquirente_url(@acquirente)
    assert_response :success
  end

  test "should update acquirente" do
    patch acquirente_url(@acquirente), params: { acquirente: {  } }
    assert_redirected_to acquirente_url(@acquirente)
  end

  test "should destroy acquirente" do
    assert_difference('Acquirente.count', -1) do
      delete acquirente_url(@acquirente)
    end

    assert_redirected_to acquirentes_url
  end
end
