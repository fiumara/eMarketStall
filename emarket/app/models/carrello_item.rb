class CarrelloItem < ApplicationRecord
  belongs_to :carrello, optional: true
  belongs_to :prodotto

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def prezzo_unitario
    prodotto.prezzo_scontato
  end

  def totale
    prezzo_unitario * quantity
  end
end
