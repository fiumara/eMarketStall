class Ordine < ApplicationRecord
  belongs_to :acquirente

  before_create :assegna_codice_ordine

  has_many :carrello_items, dependent: :destroy

  has_many :prodottos, through: :carrello_items
  has_many :negozios, -> { distinct }, through: :prodottos

  

  enum stato: { in_attesa: 'in_attesa', pagato: 'pagato', annullato: 'annullato' }

  def assegna_codice_ordine
    self.codice_ordine = loop do
      codice = "ORD-#{SecureRandom.hex(4).upcase}"
      break codice unless Ordine.exists?(codice_ordine: codice)
    end
  end
end

