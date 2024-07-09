class Promozione < ApplicationRecord
  belongs_to :negozio, optional: true
  belongs_to :prodotto, optional: true
  belongs_to :categoria, optional: true

  validates :created_by, presence: true
  validates :tipo, inclusion: { in: %w[singolo_prodotto intero_sito categoria] }

  validate :correct_association

  private

  def correct_association
    case tipo
    when 'singolo_prodotto'
      errors.add(:prodotto, 'must be present for singolo_prodotto') unless prodotto.present?
    when 'categoria'
      errors.add(:categoria, 'must be present for categoria') unless categoria.present?
    when 'intero_sito'
      errors.add(:negozio, 'cannot be present for intero_sito') if negozio.present?
    end
  end
end
