class Prodotto < ApplicationRecord
    belongs_to :negozio

    def self.search(term)
        if term
          where('LOWER(nome_prodotto) LIKE ? OR LOWER(descrizione) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%")
        else
          all
        
        has_many :wishlist_items, dependent: :destroy
        has_many :wishlisted_by, through: :wishlist_items, source: :acquirente
        
        end
      end
end
