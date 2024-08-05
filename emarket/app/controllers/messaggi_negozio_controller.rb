class MessaggiNegozioController < ApplicationController
  before_action :set_negozio, only: [:new, :create]

  def index
      @messaggi = Messaggio.all
    end
  def new
    @messaggio = Messaggio.new
  end

  def create
    @messaggio = Messaggio.new(messaggio_params)
    @messaggio.negozio = @negozio
    @messaggio.acquirente = current_acquirente # Assicurati di avere una funzione current_acquirente

    if @messaggio.save
      redirect_to messaggi_path, notice: 'Messaggio inviato con successo.'
    else
      render :new
    end
  end

  def destroy
    @messaggio = Messaggio.find(params[:id])
    @messaggio.destroy
    redirect_to messaggi_negozio_index_path, notice: 'Messaggio eliminato con successo.'
  end

  private

  def set_negozio
    @negozio = Negozio.find_by(id: params[:negozio_id])
  end

  def messaggio_params
    params.require(:messaggio).permit(:contenuto, :negozio_id, :acquirente_id, :tipo_utente)
  end
end
  