class ChatRoom < ApplicationRecord
    has_many :messaggi, dependent: :destroy
    belongs_to :mittente, polymorphic: true
    belongs_to :destinatario, polymorphic: true

    validates :mittente, presence: true
    validates :destinatario, presence: true
end
