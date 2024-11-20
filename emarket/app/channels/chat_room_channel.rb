class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    @chat_room = ChatRoom.find(params[:chat_id])
    stream_for @chat_room
  end

  def speak(data)
    messaggio = @chat_room.messaggi.create!(
      contenuto: data['message'],
      mittente: current_user
    )
    message_html = ApplicationController.render(
      partial: 'messaggi/messaggio',
      locals: { messaggio: messaggio }
    )
    ChatRoomChannel.broadcast_to(@chat_room, { message_html: message_html })
    end

  private

  def render_message(messaggio)
    ApplicationController.render(partial: 'messaggi/messaggio', locals: { messaggio: messaggio })
  end
end
