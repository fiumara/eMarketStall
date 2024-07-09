class Recensione < ApplicationRecord
    belongs_to :prodotto
    belongs_to :acquirente

    
end
