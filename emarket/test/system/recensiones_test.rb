require "application_system_test_case"

class RecensionesTest < ApplicationSystemTestCase
  setup do
    @recensione = recensiones(:one)
  end

  test "visiting the index" do
    visit recensiones_url
    assert_selector "h1", text: "Recensiones"
  end

  test "creating a Recensione" do
    visit recensiones_url
    click_on "New Recensione"

    click_on "Create Recensione"

    assert_text "Recensione was successfully created"
    click_on "Back"
  end

  test "updating a Recensione" do
    visit recensiones_url
    click_on "Edit", match: :first

    click_on "Update Recensione"

    assert_text "Recensione was successfully updated"
    click_on "Back"
  end

  test "destroying a Recensione" do
    visit recensiones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Recensione was successfully destroyed"
  end
end
