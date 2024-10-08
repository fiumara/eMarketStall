class MessaggiController < ApplicationController
  before_action :set_chat_room
  
  def create
    @messaggio = @chat_room.messaggi.build(messaggio_params)
    
    # Imposta il mittente e destinatario dalla chat room
    @messaggio.mittente_id = @chat_room.mittente_id
    @messaggio.mittente_type = @chat_room.mittente_type
    @messaggio.destinatario_id = @chat_room.destinatario_id
    @messaggio.destinatario_type = @chat_room.destinatario_type
    
    if @messaggio.save
      ActionCable.server.broadcast "chat_room_#{@chat_room.id}", message: render_message(@messaggio)
      redirect_to chat_room_path(@chat_room)
      #da rivedere il refresh
    else
      Rails.logger.debug @messaggio.errors.full_messages
      render json: { error: 'Errore nella creazione del messaggio', messages: @messaggio.errors.full_messages }
    end
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end
  
  def messaggio_params
    params.require(:messaggio).permit(:contenuto)
  end
  
  def render_message(messaggio)
    ApplicationController.render(partial: 'messaggi/messaggio', locals: { messaggio: messaggio })
  end
end
