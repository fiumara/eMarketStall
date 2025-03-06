class Prodotto < ApplicationRecord
    belongs_to :negozio
    belongs_to :categorium
    
    has_many :recensioni, dependent: :destroy

    has_many :wishlist_items, dependent: :destroy
    has_many :wishlisted_by, through: :wishlist_items, source: :acquirente
    has_many :promoziones

    has_one :statistica, dependent: :destroy
    accepts_nested_attributes_for :statistica


    validates :quantita_disponibile, numericality: { greater_than_or_equal_to: 0 }
    
    def self.search(term)
        if term
          where('LOWER(nome_prodotto) LIKE ? OR LOWER(descrizione) LIKE ?', "%#{term.downcase}%", "%#{term.downcase}%")
        else
          all
        end
      end


      def promozione_attiva
        Promozione.where("inizio <= ? AND fine >= ?", Date.today, Date.today)
                  .find_by("(tipo = ? AND prodotto_id = ?) OR 
                            (tipo = ? AND categorium_id = ?) OR 
                            (tipo = ?)",
                           'singolo_prodotto', self.id,
                           'categoria', self.categorium_id,
                           'intero_sito')
      end


      def quantita_disponibile
        self[:quantita_disponibile] || 0 # Ritorna 0 se il valore è nullo
      end
end
