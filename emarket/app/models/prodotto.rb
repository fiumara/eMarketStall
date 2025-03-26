class Prodotto < ApplicationRecord
  has_many_attached :immagini
  belongs_to :negozio
  belongs_to :categorium

  has_many :recensioni, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlisted_by, through: :wishlist_items, source: :acquirente
  has_many :promoziones

  has_one :statistica, dependent: :destroy
  accepts_nested_attributes_for :statistica

  validates :quantita_disponibile, numericality: { greater_than_or_equal_to: 0 }

  def self.search(term)
    if term
      where('LOWER(nome_prodotto) LIKE ? OR LOWER(descrizione) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%")
    else
      all
    end
  end

  # Trova la promozione attiva più recente per il prodotto o la categoria
  def promozione_attiva
    promoziones
      .where("inizio <= ? AND fine >= ?", Date.today, Date.today)
      .order(created_at: :desc)
      .first
  end

  # Restituisce il prezzo con lo sconto applicato, se presente
  def prezzo_scontato
    promo = promozione_attiva
    if promo
      [prezzo - (prezzo * promo.sconto / 100.0), 0].max # Evita prezzi negativi
    else
      prezzo
    end
  end

  def quantita_disponibile
    self[:quantita_disponibile] || 0 # Ritorna 0 se il valore è nullo
  end
end
