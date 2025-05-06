class Follow < ApplicationRecord
  belongs_to :acquirente
  belongs_to :negozio
  validates :acquirente_id, uniqueness: { scope: :negozio_id }
end
