class Acquirente < ApplicationRecord
  # Metodo per la gestione della password
  has_secure_password
  before_create :default_values


  after_initialize :set_default_punti_fedelta

  #Follower
  has_many :follows
  has_many :negozi_seguiti, through: :follows, source: :negozio


  # Associazioni
  
 
  has_one :negozio, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  has_many :wishlist, through: :wishlist_items, source: :prodotto
  has_many :return_requests, foreign_key: :acquirente_id, dependent: :destroy
  has_many :cronologia_ricercas, dependent: :destroy
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

  def create_reset_digest
    token = SecureRandom.urlsafe_base64
    update(
      reset_digest: Digest::SHA256.hexdigest(token),
      reset_sent_at: Time.current
    )
    token
  end

  def reset_token_valid?(token)
    reset_digest.present? &&
      reset_sent_at > 2.hours.ago &&
      Digest::SHA256.hexdigest(token) == reset_digest
  end

  def clear_reset_digest
    update(reset_digest: nil, reset_sent_at: nil)
  end

  def aggiungi_punti_da_ordini(ordini)
    totale = ordini.sum(&:totale)
    punti = (totale / 5).floor
    increment!(:punti, punti)
    punti
  end

  private

  def set_default_punti_fedelta
    self.punti ||= 0
  end




end
