class Messaggio < ApplicationRecord
    belongs_to :negozio
    belongs_to :acquirente
end
