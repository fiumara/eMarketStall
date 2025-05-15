class SegnalazioneNegozio < ApplicationRecord
  belongs_to :acquirente
  belongs_to :negozio

  validates :motivo, presence: true
end
