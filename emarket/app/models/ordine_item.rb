class OrdineItem < ApplicationRecord
    belongs_to :ordine
    belongs_to :prodotto
  
    before_create :applica_sconto
  
    validates :quantity, presence: true, numericality: { greater_than: 0 }
    validates :prezzo, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
    def totale
      prezzo * quantity
    end
  
    private
  
    def applica_sconto
      self.prezzo = prodotto.prezzo_scontato
    end
  end
  