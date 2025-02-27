class Acquirente < ApplicationRecord
  # Metodo per la gestione della password
  has_secure_password

  # Associazioni
  has_many :recensioni, dependent: :destroy
  has_many :messaggi, dependent: :destroy
  has_one :negozio, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlist, through: :wishlist_items, source: :prodotto

  # Messaggi personalizzati
  has_many :messaggi_inviati, as: :mittente, class_name: 'Messaggio'
  has_many :messaggi_ricevuti, as: :destinatario, class_name: 'Messaggio'

  has_one :carrello, dependent: :destroy
  after_create :create_carrello

  has_many :ordini, class_name: "Ordine", dependent: :destroy

  # Validazioni
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, unless: -> { id_acquirente.present? }

  validates :id_acquirente, uniqueness: true, allow_nil: true

  # Metodi di utilità
  def nome_completo
    "#{nome} #{cognome}"
  end

  def to_s
    nome_completo
  end

  def create_carrello
    Carrello.create(acquirente: self)
  end
end
