class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: %i[show create_message]
  before_action :authenticate_user!
  before_action :authorize_chat_access, only: %i[show create_message destroy]
  before_action :set_destinatari_options, only: %i[new create]
  
  

  def index
    if current_user.is_a?(Amministratore)
      @chat_rooms = ChatRoom.where("(mittente_type = ? OR destinatario_type = ?)", "Amministratore", "Amministratore")
                             .where("(mittente_type != ? OR mittente_visible = ?) AND (destinatario_type != ? OR destinatario_visible = ?)",
                                    current_user.class.name, true,
                                    current_user.class.name, true)
    else
      @chat_rooms = ChatRoom.where(
        "(mittente_id = ? AND mittente_type = ? AND mittente_visible = ?) OR (destinatario_id = ? AND destinatario_type = ? AND destinatario_visible = ?)",
        current_user.id, current_user.class.name, true,
        current_user.id, current_user.class.name, true
      )
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
    @chat_room = ChatRoom.find(params[:chat_room_id] || params[:id])
  
    # Riattiva visibilità per mittente e destinatario (in caso l'altro l'avesse eliminata)
    if current_user == @chat_room.mittente
      @chat_room.update(destinatario_visible: true)
    elsif current_user == @chat_room.destinatario
      @chat_room.update(mittente_visible: true)
    end
  
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
  

  def destroy
    @chat_room = ChatRoom.find(params[:id])
  
    if @chat_room.mittente == current_user
      @chat_room.update(mittente_visible: false)
    elsif @chat_room.destinatario == current_user
      @chat_room.update(destinatario_visible: false)
    else
      redirect_to chat_rooms_path, alert: "Non sei autorizzato." and return
    end
  
    if !@chat_room.mittente_visible && !@chat_room.destinatario_visible
      @chat_room.destroy
    end
  
    redirect_to chat_rooms_path, notice: "Chat eliminata con successo."
  end
  
  
  

  private

  def set_chat_room
    @chat_room = ChatRoom.find_by(id: params[:id] || params[:chat_room_id])
    redirect_to chat_rooms_path, alert: 'Chat room non trovata.' if @chat_room.nil?
  end
  

  def authorized_user?(chat_room)
    return true if current_user.is_a?(Amministratore) &&
                   (chat_room.mittente_type == "Amministratore" || chat_room.destinatario_type == "Amministratore")
  
    (current_user.id == chat_room.mittente_id && current_user.class.name == chat_room.mittente_type) ||
      (current_user.id == chat_room.destinatario_id && current_user.class.name == chat_room.destinatario_type)
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


  def authorize_chat_access
    unless authorized_user?(@chat_room)
      redirect_to chat_rooms_path, alert: 'Accesso negato: non sei autorizzato a visualizzare questa chat.'
    end
  end

end
