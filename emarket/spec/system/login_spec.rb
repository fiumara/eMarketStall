require 'rails_helper'

RSpec.describe "Login", type: :system do
  let!(:acquirente) do
    Acquirente.create!(
      email: "acquirente@example.com",
      password: "password123",
      nome: "Mario",
      cognome: "Rossi",
      id_acquirente: SecureRandom.uuid
    )
  end

  it "effettua il login con credenziali valide per acquirente" do
    visit login_path

    # Selezione del ruolo
    choose "Acquirente" # corrisponde all'etichetta del radio button

    fill_in "Email", with: "acquirente@example.com"
    fill_in "Password", with: "password123"
    click_button "Accedi"

    expect(page).to have_content("Accesso effettuato con successo")
    expect(current_path).to eq(acquirente_path(acquirente))
  end

  it "mostra errore con credenziali errate" do
    visit login_path

    choose "Acquirente"
    fill_in "Email", with: "acquirente@example.com"
    fill_in "Password", with: "sbagliata"
    click_button "Accedi"

    expect(page).to have_content("Email o password non validi.")
  end

  it "mostra errore se acquirente è bloccato" do
    acquirente.update(bloccato: true)

    visit login_path

    choose "Acquirente"
    fill_in "Email", with: "acquirente@example.com"
    fill_in "Password", with: "password123"
    click_button "Accedi"

    expect(page).to have_content("Il tuo account è stato bloccato")
  end
end
