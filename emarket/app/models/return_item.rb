class ReturnItem < ApplicationRecord
  belongs_to :return_request
  belongs_to :prodotto

  validates :quantita, numericality: { greater_than: 0 }
  validate :quantita_non_superiore_all_acquisto

  private

  def quantita_non_superiore_all_acquisto
    ordine = return_request.ordine
    max_quantita = ordine.ordine_items.find_by(prodotto: prodotto)&.quantity || 0

    if quantita > max_quantita
      errors.add(:quantita, "non può superare la quantità acquistata")
    end
  end
end
