class ChatRoomChannel < ApplicationCable::Channel

  def subscribed
    chat_room = ChatRoom.find(params[:chat_room_id])
    stream_for chat_room
  end

  def unsubscribed
    # Logica quando si interrompe l'abbonamento
  end

  def send_message(data)
    chat_room = ChatRoom.find(data['chat_room_id'])
    messaggio = chat_room.messaggi.create!(
      contenuto: data['contenuto'],
      mittente: current_user,
      destinatario_id: data['destinatario_id'],
      destinatario_type: data['destinatario_type']
    )

    ActionCable.server.broadcast "chat_room_#{chat_room.id}", message: render_message(messaggio)
  end

  private

  def render_message(messaggio)
    ApplicationController.render(partial: 'messaggi/messaggio', locals: { messaggio: messaggio })
  end
end
