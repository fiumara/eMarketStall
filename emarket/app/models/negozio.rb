class Negozio < ApplicationRecord
    belongs_to :acquirente
    has_many :prodottos, dependent: :destroy

    has_many :messaggi, dependent: :destroy
end
