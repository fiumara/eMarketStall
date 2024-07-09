class Prodotto < ApplicationRecord
    belongs_to :negozio
    belongs_to :categorium

    has_many :wishlist_items, dependent: :destroy
    has_many :wishlisted_by, through: :wishlist_items, source: :acquirente
    has_many :promoziones

    has_one :statistica, dependent: :destroy
    accepts_nested_attributes_for :statistica


    def self.search(term)
        if term
          where('LOWER(nome_prodotto) LIKE ? OR LOWER(descrizione) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%")
        else
          all
        end
      end
end
