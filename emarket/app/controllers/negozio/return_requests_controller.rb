class Negozio::ReturnRequestsController < ApplicationController
    before_action :authenticate_acquirente!
    before_action :set_negozio
    before_action :set_return_request, only: [:show, :update]
  
    def index
      @return_requests = ReturnRequest.joins(:ordine).where(ordini: { negozio_id: @negozio.id }).order(created_at: :desc)
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
  
    private
  
    def set_negozio
      @negozio = current_user.negozio
    end
  
    def set_return_request
      @return_request = ReturnRequest.find(params[:id])
    end
  end