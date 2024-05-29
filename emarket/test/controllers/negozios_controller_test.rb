require "test_helper"

class NegoziosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @negozio = negozios(:one)
  end

  test "should get index" do
    get negozios_url
    assert_response :success
  end

  test "should get new" do
    get new_negozio_url
    assert_response :success
  end

  test "should create negozio" do
    assert_difference('Negozio.count') do
      post negozios_url, params: { negozio: {  } }
    end

    assert_redirected_to negozio_url(Negozio.last)
  end

  test "should show negozio" do
    get negozio_url(@negozio)
    assert_response :success
  end

  test "should get edit" do
    get edit_negozio_url(@negozio)
    assert_response :success
  end

  test "should update negozio" do
    patch negozio_url(@negozio), params: { negozio: {  } }
    assert_redirected_to negozio_url(@negozio)
  end

  test "should destroy negozio" do
    assert_difference('Negozio.count', -1) do
      delete negozio_url(@negozio)
    end

    assert_redirected_to negozios_url
  end
end
