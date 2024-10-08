class ChatRoomsController < ApplicationController
    before_action :set_chat_room, only: [:show]
    before_action :set_destinatari_options, only: [:new, :create]
  
    # GET /chat_rooms
    def index
      @chat_rooms = ChatRoom.all
    end
  
    # GET /chat_rooms/:id
    def show
      @chat_room = ChatRoom.find(params[:id])
      @messaggi = @chat_room.messaggi || []
      @destinatario = @chat_room.destinatario
    end

    def new
        @chat_room = ChatRoom.new
      end
    
      # Azione per creare una nuova chat room
      def create
        @chat_room = ChatRoom.new(chat_room_params)
        @chat_room.mittente_id = current_user.id
        @chat_room.mittente_type = current_user.class.name
        @chat_room.destinatario_id = params[:chat_room][:destinatario_id]
        @chat_room.destinatario_type = params[:chat_room][:destinatario_type]
        
        if @chat_room.save
          redirect_to @chat_room, notice: 'Chat room creata con successo!'
        else
          render :new
        end
      end
    
      private
    
      def set_chat_room
        @chat_room = ChatRoom.find(params[:id])
      end
    
      def set_destinatari_options
        # Popola i destinatari che l'utente può scegliere (acquirenti, amministratori, negozi)
        @destinatari_options = Acquirente.all + Amministratore.all + Negozio.all
      end
    
      def chat_room_params
        params.require(:chat_room).permit(:nome)
      end
    end