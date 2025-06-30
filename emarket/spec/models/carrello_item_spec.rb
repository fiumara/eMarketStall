require 'rails_helper'

RSpec.describe CarrelloItem, type: :model do
  describe '#totale' do
    it 'calcola il totale corretto con prezzo scontato' do
      acquirente = Acquirente.create!(nome: "Test", email: "a@b.it", password: "password")
      negozio = acquirente.create_negozio!(
        nome_negozio: "Test Shop",
        telefono: "123456789"
      )
      categoria = Categorium.create!(nome: "Accessori")

      prodotto = negozio.prodottos.create!(
      nome_prodotto: "T-Shirt",
      prezzo: 20,
      quantita_disponibile: 100,
      descrizione: "Cotone 100%",
      categorium_id: categoria.id
      )


      allow(prodotto).to receive(:prezzo_scontato).and_return(15)

      item = CarrelloItem.new(prodotto: prodotto, quantity: 2)
      expect(item.totale).to eq(30)
    end
  end
end
