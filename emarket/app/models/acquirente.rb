class Acquirente < ApplicationRecord
  # Metodo per la gestione della password
  has_secure_password
  before_create :default_values

 

  # Associazioni
  
 
  has_one :negozio, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlist, through: :wishlist_items, source: :prodotto
  has_many :return_requests, foreign_key: :acquirente_id, dependent: :destroy

  has_many :feedbacks

  # Messaggi personalizzati
  has_many :messaggi_inviati, as: :mittente, class_name: 'Messaggio', dependent: :destroy
  has_many :messaggi_ricevuti, as: :destinatario, class_name: 'Messaggio', dependent: :destroy
  
  has_one :carrello, dependent: :destroy
  after_create :create_carrello

  has_many :ordini, class_name: "Ordine", dependent: :destroy

  # Validazioni
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create


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

  def default_values
    self.bloccato ||= false
  end
end
