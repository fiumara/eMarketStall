class Negozio < ApplicationRecord
    belongs_to :acquirente
    has_many :prodottos, dependent: :destroy
    has_many :promoziones, dependent: :destroy

    has_many :messaggi_inviati, as: :mittente, class_name: 'Messaggio', dependent: :destroy
    has_many :messaggi_ricevuti, as: :destinatario, class_name: 'Messaggio', dependent: :destroy

    def nome_completo
        nome_negozio
      end
end
