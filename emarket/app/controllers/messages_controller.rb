class MessagesController < ApplicationController
    def new
      @negozio = Negozio.find(params[:negozio_id])
      @message = Message.new
    end
  
    def create
      @message = Message.new(message_params)
      if @message.save
        redirect_to @message.negozio, notice: 'Messaggio inviato con successo.'
      else
        render :new
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:negozio_id, :content)
    end
  end
  