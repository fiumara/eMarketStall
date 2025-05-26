class NegozioReturnRequestsController < ApplicationController
    before_action :authenticate_acquirente! # Assicurati di avere un metodo di autenticazione corretto
    before_action :set_return_request, only: [:show, :update, :approve, :reject]
    before_action :authorize_negozio_return_request, only: [:show, :update, :approve, :reject]


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
      ActiveRecord::Base.transaction do
        if @return_request.approvato!
          @return_request.return_items.each do |item|
            prodotto = item.prodotto
            prodotto.increment!(:quantita_disponibile, item.quantita)
          end
    
          ordine = @return_request.ordine
    
          # Calcolo dell'importo del rimborso
          totale_reso = @return_request.return_items.inject(0) do |somma, item|
            ordine_item = ordine.ordine_items.find_by(prodotto_id: item.prodotto_id)
            if ordine_item
              somma + (item.quantita * ordine_item.prezzo)
            else
              somma
            end
          end
    
          if ordine.stripe_payment_intent_id.present?
            Stripe::Refund.create({
              payment_intent: ordine.stripe_payment_intent_id,
              amount: (totale_reso * 100).to_i, # Importo in centesimi
            })
          end
    
          redirect_to negozio_return_requests_path, notice: "Reso approvato e rimborso eseguito."
        else
          redirect_to negozio_return_requests_path, alert: "Errore nell'approvazione del reso."
        end
      end
    rescue Stripe::StripeError => e
      redirect_to negozio_return_requests_path, alert: "Errore durante il rimborso: #{e.message}"
    end
    
    
    
  
    def reject
      @return_request.update!(stato: "rifiutato")
      redirect_to negozio_return_requests_path, alert: "Reso rifiutato."
    end
  
    private
  
    def set_return_request
      @return_request = ReturnRequest.find(params[:id])
    end
    
    def authorize_negozio_return_request
      unless @return_request.ordine.negozio == current_user.negozio
        redirect_to root_path, alert: "Accesso negato."
      end
    end
  end
  