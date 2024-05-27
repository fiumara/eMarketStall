require "application_system_test_case"

class AcquirentesTest < ApplicationSystemTestCase
  setup do
    @acquirente = acquirentes(:one)
  end

  test "visiting the index" do
    visit acquirentes_url
    assert_selector "h1", text: "Acquirentes"
  end

  test "creating a Acquirente" do
    visit acquirentes_url
    click_on "New Acquirente"

    click_on "Create Acquirente"

    assert_text "Acquirente was successfully created"
    click_on "Back"
  end

  test "updating a Acquirente" do
    visit acquirentes_url
    click_on "Edit", match: :first

    click_on "Update Acquirente"

    assert_text "Acquirente was successfully updated"
    click_on "Back"
  end

  test "destroying a Acquirente" do
    visit acquirentes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Acquirente was successfully destroyed"
  end
end
