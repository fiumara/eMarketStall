require "test_helper"

class VariantisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @varianti = variantis(:one)
  end

  test "should get index" do
    get variantis_url
    assert_response :success
  end

  test "should get new" do
    get new_varianti_url
    assert_response :success
  end

  test "should create varianti" do
    assert_difference('Varianti.count') do
      post variantis_url, params: { varianti: {  } }
    end

    assert_redirected_to varianti_url(Varianti.last)
  end

  test "should show varianti" do
    get varianti_url(@varianti)
    assert_response :success
  end

  test "should get edit" do
    get edit_varianti_url(@varianti)
    assert_response :success
  end

  test "should update varianti" do
    patch varianti_url(@varianti), params: { varianti: {  } }
    assert_redirected_to varianti_url(@varianti)
  end

  test "should destroy varianti" do
    assert_difference('Varianti.count', -1) do
      delete varianti_url(@varianti)
    end

    assert_redirected_to variantis_url
  end
end
