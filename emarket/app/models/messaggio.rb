class Messaggio < ApplicationRecord
  belongs_to :chat_room
  

  validates :contenuto, presence: true

  after_create_commit do
    ChatRoomChannel.broadcast_to(self.chat_room, render_message(self))
  end

  private

  def render_message(messaggio)
    ApplicationController.renderer.render(partial: 'messaggi/messaggio', locals: { messaggio: messaggio })
  end
end
