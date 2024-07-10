class MessaggiNegozioController < ApplicationController
    def index
      @messaggi = Messaggio.all
    end
  
    def create
      @messaggio = Messaggio.new(messaggio_params)
      if @messaggio.save
        redirect_to messaggi_negozio_index_path, notice: 'Messaggio inviato con successo.'
      else
        render :index, alert: 'Errore nell\'invio del messaggio.'
      end
    end
  
    def destroy
      @messaggio = Messaggio.find(params[:id])
      @messaggio.destroy
      redirect_to messaggi_negozio_index_path, notice: 'Messaggio eliminato con successo.'
    end
  
    private
  
    def messaggio_params
      params.require(:messaggio).permit(:contenuto, :negozio_id, :acquirente_id, :tipo_utente)
    end
  end
  