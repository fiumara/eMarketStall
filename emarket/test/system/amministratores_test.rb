require "application_system_test_case"

class AmministratoresTest < ApplicationSystemTestCase
  setup do
    @amministratore = amministratores(:one)
  end

  test "visiting the index" do
    visit amministratores_url
    assert_selector "h1", text: "Amministratores"
  end

  test "creating a Amministratore" do
    visit amministratores_url
    click_on "New Amministratore"

    click_on "Create Amministratore"

    assert_text "Amministratore was successfully created"
    click_on "Back"
  end

  test "updating a Amministratore" do
    visit amministratores_url
    click_on "Edit", match: :first

    click_on "Update Amministratore"

    assert_text "Amministratore was successfully updated"
    click_on "Back"
  end

  test "destroying a Amministratore" do
    visit amministratores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Amministratore was successfully destroyed"
  end
end
