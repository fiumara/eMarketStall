class ReturnRequest < ApplicationRecord
  belongs_to :ordine
  belongs_to :acquirente, class_name: "Acquirente" 
  has_many :return_items, dependent: :destroy
  accepts_nested_attributes_for :return_items, allow_destroy: true, reject_if: proc { |attributes| attributes['quantita'].to_i <= 0 }

  enum stato: { in_attesa: 0, approvato: 1, rifiutato: 2 }

  validates :motivo, presence: true
  validate :valid_quantities

  private

  def valid_quantities
    return_items.each do |return_item|
      ordine_item = ordine.ordine_items.find_by(prodotto_id: return_item.prodotto_id)
  
      if ordine_item.nil?
        errors.add(:return_items, "Il prodotto selezionato non è presente nell'ordine")
      elsif return_item.quantita > ordine_item.quantity
        errors.add(:return_items, "Quantità per #{return_item.prodotto.nome_prodotto} superiore a quella acquistata")
      end
    end
  end
  
  
end
