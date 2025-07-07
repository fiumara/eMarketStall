class Feedback < ApplicationRecord
  belongs_to :acquirente, optional: true 
  belongs_to :prodotto
  belongs_to :ordine_item

  validates :voto, presence: true, inclusion: { in: 1..5, message: "deve essere tra 1 e 5" }
  validates :nota, length: { maximum: 1000 }, allow_blank: true

  validates :ordine_item_id, uniqueness: true  

  scope :segnalati, -> { where(segnalato: true) }

  def segnala!
    update(segnalato: true)
  end
end
