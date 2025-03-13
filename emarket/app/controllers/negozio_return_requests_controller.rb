class NegozioReturnRequestsController < ApplicationController
    before_action :authenticate_acquirente! # Assicurati di avere un metodo di autenticazione corretto
    before_action :set_return_request, only: [:show, :update, :approve, :reject]

    def index
      @return_requests = ReturnRequest.joins(:ordine)
                                      .where(ordini: { negozio_id: current_user.negozio.id })
                                      .order(created_at: :desc)
    end
  
    def show
    end
  
    def update
      if @return_request.update(stato: params[:stato])
        redirect_to negozio_return_requests_path, notice: "Stato della richiesta di reso aggiornato."
      else
        render :show
      end
    end

    def approve
      if @return_request.approvato!
        @return_request.return_items.each do |item|
          prodotto = item.prodotto
          prodotto.increment!(:quantita_disponibile, item.quantita)
        end
        redirect_to negozio_return_requests_path, notice: "Reso approvato con successo."
      else
        redirect_to negozio_return_requests_path, alert: "Errore nell'approvazione del reso."
      end
    end
    
  
    def reject
      @return_request.update!(stato: "rifiutato")
      redirect_to negozio_return_requests_path, alert: "Reso rifiutato."
    end
  
    private
  
    def set_return_request
      @return_request = ReturnRequest.find(params[:id])
    end
  end
  