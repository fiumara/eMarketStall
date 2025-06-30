class Negozio < ApplicationRecord
    belongs_to :acquirente
    has_many :prodottos, dependent: :destroy
    has_many :promoziones, dependent: :destroy
    has_many :follows
    has_many :followers, through: :follows, source: :acquirente
    has_many :messaggi_inviati, as: :mittente, class_name: 'Messaggio', dependent: :destroy
    has_many :messaggi_ricevuti, as: :destinatario, class_name: 'Messaggio', dependent: :destroy
    has_many :segnalazioni_negozi, class_name: 'SegnalazioneNegozio', dependent: :destroy

    has_one_attached :immagine # <--- aggiunto

    def nome_completo
        nome_negozio
    end
    validates :nome_negozio, :telefono, presence: true
    validate :immagine_must_be_variable

    def immagine_must_be_variable
      if immagine.attached? && !immagine.variable?
        errors.add(:immagine, "non è un formato immagine valido o non può essere elaborata")
      end
    end
end
