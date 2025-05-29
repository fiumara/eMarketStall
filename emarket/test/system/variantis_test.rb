require "application_system_test_case"

class VariantisTest < ApplicationSystemTestCase
  setup do
    @varianti = variantis(:one)
  end

  test "visiting the index" do
    visit variantis_url
    assert_selector "h1", text: "Variantis"
  end

  test "creating a Varianti" do
    visit variantis_url
    click_on "New Varianti"

    click_on "Create Varianti"

    assert_text "Varianti was successfully created"
    click_on "Back"
  end

  test "updating a Varianti" do
    visit variantis_url
    click_on "Edit", match: :first

    click_on "Update Varianti"

    assert_text "Varianti was successfully updated"
    click_on "Back"
  end

  test "destroying a Varianti" do
    visit variantis_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Varianti was successfully destroyed"
  end
end
