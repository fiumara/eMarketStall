require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Aggiunta prodotto al carrello', type: :system, js: true do
    before do
        driven_by(:rack_test)
      
        @acquirente = Acquirente.create!(
          nome: "Mario",
          email: "user@example.com",
          password: "password123"
        )
        @negozio = @acquirente.create_negozio!(nome_negozio: "Negozio Test")
      
        @categoria = Categorium.create!(nome: "Gioielli") # ✅ aggiunta categoria
      
        @prodotto = @negozio.prodottos.create!(
          nome_prodotto: "Anello",
          prezzo: 40,
          quantita_disponibile: 5,
          categorium: @categoria # ✅ associata categoria
        )
      
        stub_request(:get, /translation.googleapis.com/).to_return(
          body: '{"data":{"translations":[{"translatedText":"Anello aggiunto al carrello!"}]}}',
          headers: { 'Content-Type' => 'application/json' }
        )
      end
      

      it 'acquirente effettua login e aggiunge un prodotto al carrello' do
        visit login_path
        fill_in 'Email', with: @acquirente.email
        fill_in 'Password', with: 'password123'
        choose('role_acquirente') # ✅ seleziona esplicitamente il ruolo
        click_button I18n.t('sessions.login') # usa la traduzione reale

      
        visit prodotto_path(@prodotto)
        fill_in 'quantity', with: 2
        click_button I18n.t('prodotto.agg') # ✅ usa la traduzione corretta
      
        expect(page).to have_content("Anello aggiunto al carrello!")
        expect(@acquirente.reload.carrello.carrello_items.count).to eq(1)
      end
      
end
