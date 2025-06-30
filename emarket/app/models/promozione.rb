class Promozione < ApplicationRecord
  belongs_to :negozio, optional: true
  belongs_to :prodotto, optional: true
  belongs_to :categorium, optional: true

  validates :nome, :descrizione, :inizio, :fine, :sconto, :tipo, presence: true
  validates :prodotto_id, presence: true, if: -> { tipo == 'singolo_prodotto' }
  validates :categorium_id, presence: true, if: -> { tipo == 'categoria' }
  validates :created_by, presence: true
  validates :tipo, inclusion: { in: %w[singolo_prodotto intero_sito categoria] }

  validate :correct_association

  private

  def correct_association
    case tipo
    when 'singolo_prodotto'
      errors.add(:prodotto, 'must be present for singolo_prodotto') unless prodotto_id.present?
    when 'categoria'
      errors.add(:categorium, 'must be present for categoria') unless categorium_id.present?
    when 'intero_sito'
      errors.add(:negozio, 'must be present for intero_sito') if negozio_id.present?
    end
  end
  
end
