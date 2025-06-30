class Prodotto < ApplicationRecord
  has_many_attached :immagini, dependent: :destroy
  belongs_to :negozio
  belongs_to :categoria, class_name: 'Categorium', foreign_key: 'categorium_id'


  has_many :wishlist_items, dependent: :destroy
  has_many :wishlisted_by, through: :wishlist_items, source: :acquirente
  has_many :promoziones, dependent: :destroy
  has_many :carrello_items, dependent: :destroy
  has_many :ordine_items
  has_many :cronologia_ricercas, dependent: :destroy

  has_many :feedbacks, dependent: :destroy

  has_one :statistica, dependent: :destroy
  accepts_nested_attributes_for :statistica
  validates :nome_prodotto, presence: true
  validates :descrizione, presence: true
  validates :prezzo, presence: true, numericality: { greater_than: 0 }
  validates :categorium_id, presence: true
  validates :quantita_disponibile, presence: true, numericality: { greater_than: 0 }

  def self.search(term)
    if term
      where('LOWER(nome_prodotto) LIKE ? OR LOWER(descrizione) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%")
    else
      all
    end
  end

  # Trova la promozione attiva più recente per il prodotto o la categoria
  def promozione_attiva
    oggi = Date.today
  
    Promozione.where("inizio <= ? AND fine >= ?", oggi, oggi)
              .where(
                "prodotto_id = :pid OR categorium_id = :cid OR negozio_id = :nid OR 
                (prodotto_id IS NULL AND categorium_id IS NULL AND negozio_id IS NULL)",
                pid: self.id,
                cid: self.categorium_id,
                nid: self.negozio_id
              )
              .order(sconto: :desc)
              .first
  end
  
  # Restituisce il prezzo con lo sconto applicato, se presente
  def prezzo_scontato
    oggi = Date.today
  
    promozioni_attive = Promozione.where("inizio <= ? AND fine >= ?", oggi, oggi)
      .where("prodotto_id = ? OR categorium_id = ? OR tipo = ?", id, categorium_id, 'intero_sito')
  
    migliore_promozione = promozioni_attive.max_by(&:sconto)
  
    if migliore_promozione.present?
      prezzo - (prezzo * (migliore_promozione.sconto / 100.0))
    else
      prezzo
    end
  end
  
  def quantita_disponibile
    self[:quantita_disponibile] || 0 # Ritorna 0 se il valore è nullo
  end
end
