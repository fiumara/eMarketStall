class Ordine < ApplicationRecord
  belongs_to :acquirente
  belongs_to :negozio, optional: true  

  before_create :assegna_codice_ordine

  #Assiciazioni
  has_many :ordine_items, dependent: :destroy
  has_many :prodottos, through: :ordine_items

  has_many :return_requests, dependent: :destroy  
  
  enum stato: { 
    in_attesa: 'in_attesa', 
    pagato: 'pagato', 
    annullato: 'annullato',
    in_preparazione: 'in_preparazione',
    spedito: 'spedito',
    completato: 'completato'
  }

  def totale
    ordine_items.sum(&:totale)
  end

  def punti_per_ordine
    (totale / 5).floor
  end


  private

  def assegna_codice_ordine
    self.codice_ordine = loop do
      codice = "ORD-#{SecureRandom.hex(4).upcase}"
      break codice unless Ordine.exists?(codice_ordine: codice)
    end
  end
end

