require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "CarrelloItems", type: :request do
    before do
        @acquirente = Acquirente.create!(
          nome: "Mario",
          email: "test@example.com",
          password: "password123"
        )
        @negozio = @acquirente.create_negozio!(nome_negozio: "Il Mio Negozio")
      
        @categoria = Categorium.create!(nome: "Accessori") # ✅ aggiunta categoria
      
        @prodotto = @negozio.prodottos.create!(
          nome_prodotto: "Borsa artigianale",
          prezzo: 50,
          quantita_disponibile: 10,
          categorium: @categoria # ✅ associata categoria
        )
      
        stub_request(:get, /translation.googleapis.com/).to_return(
          body: '{"data":{"translations":[{"translatedText":"Borsa artigianale aggiunto al carrello!"}]}}',
          headers: { 'Content-Type' => 'application/json' }
        )
      
        post login_path, params: {
          email: @acquirente.email,
          password: "password123",
          role: "acquirente"
        }
      end
      

  it 'aggiunge un prodotto al carrello' do
    post carrello_items_path, params: {
      prodotto_id: @prodotto.id,
      quantity: 2
    }

    expect(response).to redirect_to(carrello_path)
    follow_redirect!
    expect(response.body).to include("Borsa artigianale aggiunto al carrello!")

    item = @acquirente.carrello.carrello_items.find_by(prodotto: @prodotto)
    expect(item.quantity).to eq(2)
  end
end
