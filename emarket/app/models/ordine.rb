class Ordine < ApplicationRecord
  belongs_to :acquirente

  before_create :assegna_codice_ordine
  belongs_to :negozio 

  has_many :carrello_items, dependent: :destroy

  has_many :prodottos, through: :carrello_items
  
   
  has_many :return_requests, dependent: :destroy  # Associazione con i resi
  

  enum stato: { 
    in_attesa: 'in_attesa', 
    pagato: 'pagato', 
    annullato: 'annullato',
    in_preparazione: 'in_preparazione',
    spedito: 'spedito',
    completato: 'completato'
  }

  def assegna_codice_ordine
    self.codice_ordine = loop do
      codice = "ORD-#{SecureRandom.hex(4).upcase}"
      break codice unless Ordine.exists?(codice_ordine: codice)
    end
  end
end

