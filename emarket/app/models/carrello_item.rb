class CarrelloItem < ApplicationRecord
  belongs_to :carrello, optional: true
  belongs_to :prodotto

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  # Usa il prezzo scontato se presente
  def prezzo_unitario
    prodotto.prezzo_scontato
  end

  # Calcola il totale con lo sconto applicato
  def totale
    prezzo_unitario * quantity
  end
end
