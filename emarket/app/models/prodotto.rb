class Prodotto < ApplicationRecord
    belongs_to :negozio

    def self.search(term)
        if term
          where('LOWER(nome_prodotto) LIKE ? OR LOWER(descrizione) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%")
        else
          all
        end
      end
end
