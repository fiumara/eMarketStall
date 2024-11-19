class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :create_message]
  before_action :set_destinatari_options, only: [:new, :create]

  def index
    @chat_rooms = ChatRoom.all
  end

  def show
    @messaggi = @chat_room.messaggi || []
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.mittente = current_user
    @chat_room.destinatario_type = params[:chat_room][:destinatario_type]
    @chat_room.destinatario_id = params[:chat_room][:destinatario_id]

    if @chat_room.save
      redirect_to @chat_room, notice: 'Chat room creata con successo!'
    else
      render :new
    end
  end

  # Creazione di un nuovo messaggio
  def create_message
    messaggio = @chat_room.messaggi.build(
      messaggio_params.merge(
        mittente_type: current_user.class.name,
        mittente_id: current_user.id,
        destinatario_type: @chat_room.destinatario_type,
        destinatario_id: @chat_room.destinatario_id
      )
    )
  
    respond_to do |format|
      if messaggio.save
        ChatRoomChannel.broadcast_to(@chat_room, render_message(messaggio))
        format.js { render partial: 'messaggi/messaggio', locals: { messaggio: messaggio } }
        format.html { redirect_to @chat_room, notice: 'Messaggio inviato con successo!' }
      else
        format.json { render json: { status: :unprocessable_entity, errors: messaggio.errors.full_messages }, status: :unprocessable_entity }
        format.html { redirect_to @chat_room, alert: 'Errore nell\'invio del messaggio.' }
      end
    end
  end
  
  

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id] || params[:chat_room_id])
  end


  def set_destinatari_options
    @destinatari_options = Acquirente.all + Amministratore.all + Negozio.all
  end

  def chat_room_params
    params.require(:chat_room).permit(:nome, :destinatario_id, :destinatario_type)
  end

  def messaggio_params
    params.require(:messaggio).permit(:contenuto)
  end

  def render_message(messaggio)
    ApplicationController.render(partial: 'messaggi/messaggio', locals: { messaggio: messaggio })
  end
end
