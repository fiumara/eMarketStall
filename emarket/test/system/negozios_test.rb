require "application_system_test_case"

class NegoziosTest < ApplicationSystemTestCase
  setup do
    @negozio = negozios(:one)
  end

  test "visiting the index" do
    visit negozios_url
    assert_selector "h1", text: "Negozios"
  end

  test "creating a Negozio" do
    visit negozios_url
    click_on "New Negozio"

    click_on "Create Negozio"

    assert_text "Negozio was successfully created"
    click_on "Back"
  end

  test "updating a Negozio" do
    visit negozios_url
    click_on "Edit", match: :first

    click_on "Update Negozio"

    assert_text "Negozio was successfully updated"
    click_on "Back"
  end

  test "destroying a Negozio" do
    visit negozios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Negozio was successfully destroyed"
  end
end
