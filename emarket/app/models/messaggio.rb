class Messaggio < ApplicationRecord
  belongs_to :chat_room
  validates :contenuto, presence: true
  belongs_to :mittente, polymorphic: true
  belongs_to :destinatario, polymorphic: true

end

