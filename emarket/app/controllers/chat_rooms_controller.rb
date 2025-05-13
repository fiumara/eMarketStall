class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: %i[show create_message]
  before_action :set_destinatari_options, only: %i[new create]

  def index
    if current_user.is_a?(Amministratore)
      @chat_rooms = ChatRoom.where("mittente_type = ? OR destinatario_type = ?", "Amministratore", "Amministratore")
    else
      @chat_rooms = ChatRoom.where("mittente_id = ? OR destinatario_id = ?", current_user.id, current_user.id)
    end
  end
  

  def show
    @messaggi = @chat_room.messaggi.order(created_at: :asc)
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.mittente = current_user
  
    destinatario = (Acquirente.find_by(id: params[:chat_room][:destinatario_id]) ||
                    Negozio.find_by(id: params[:chat_room][:destinatario_id]))
  
    @chat_room.destinatario = destinatario
  
    if @chat_room.save
      redirect_to @chat_room, notice: 'Chat room creata con successo!'
    else
      flash.now[:alert] = 'Errore nella creazione della chat room.'
      render :new, status: :unprocessable_entity
    end
  end
  

  def create_message
    messaggio = @chat_room.messaggi.build(
      messaggio_params.merge(
        mittente: current_user,
        destinatario_type: @chat_room.destinatario_type,
        destinatario_id: @chat_room.destinatario_id
      )
    )

    if messaggio.save
      ChatRoomChannel.broadcast_to(@chat_room, render_message(messaggio))
      respond_to do |format|
        format.js { render partial: 'messaggi/messaggio', locals: { messaggio: messaggio } }
        format.html { redirect_to @chat_room, notice: 'Messaggio inviato con successo!' }
      end
    else
      respond_to do |format|
        format.json { render json: { errors: messaggio.errors.full_messages }, status: :unprocessable_entity }
        format.html { redirect_to @chat_room, alert: 'Errore nell\'invio del messaggio.' }
      end
    end
  end

  def start
    unless current_user.is_a?(Acquirente)
      redirect_to root_path, alert: "Solo gli acquirenti possono contattare i negozi."
      return
    end
    
    destinatario = Negozio.find(params[:destinatario_id])
    mittente = current_user
  
    chat_room = ChatRoom.find_by(
      mittente: mittente,
      destinatario: destinatario
    ) || ChatRoom.find_by(
      mittente: destinatario,
      destinatario: mittente
    )
  
    unless chat_room
      chat_room = ChatRoom.create!(
        mittente: mittente,
        destinatario: destinatario,
        nome: "Chat con #{destinatario.nome_negozio}" # oppure quello che preferisci
      )
    end
  
    redirect_to chat_room_path(chat_room)
  end

  def assistenza
    mittente = current_user
    destinatario = Amministratore.designato
  
    chat_room = ChatRoom.find_by(
      mittente: mittente,
      destinatario: destinatario
    ) || ChatRoom.find_by(
      mittente: destinatario,
      destinatario: mittente
    )
  
    unless chat_room
      chat_room = ChatRoom.create!(
        mittente: mittente,
        destinatario: destinatario,
        nome: "Assistenza #{mittente.nome_utente}"
      )
    end
  
    redirect_to chat_room_path(chat_room)
  end
  
  

  private

def set_chat_room
  @chat_room = ChatRoom.find_by(id: params[:id] || params[:chat_room_id])
  
  if @chat_room.nil?
    redirect_to chat_rooms_path, alert: 'Chat room non trovata.'
  elsif !authorized_user?(@chat_room)
    redirect_to chat_rooms_path, alert: 'Non sei autorizzato ad accedere a questa chatroom.'
  end
end

def authorized_user?(chat_room)
  return true if current_user.is_a?(Amministratore) &&
                 (chat_room.mittente_type == "Amministratore" || chat_room.destinatario_type == "Amministratore")

    current_user.id == chat_room.mittente_id || current_user.id == chat_room.destinatario_id
end


  def set_destinatari_options
    @destinatari_options = Acquirente.all + Negozio.all
  end

  def chat_room_params
    params.require(:chat_room).permit(:nome, :destinatario_id, :destinatario_type)
  end

  def messaggio_params
    params.require(:messaggio).permit(:contenuto)
  end

  def render_message(messaggio)
    ApplicationController.render(
      partial: 'messaggi/messaggio',
      locals: { messaggio: messaggio }
    )
  end
end
