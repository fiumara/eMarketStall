class ReturnRequestsController < ApplicationController
  before_action :authenticate_acquirente!
  before_action :set_return_request, only: [:show, :update]

  def index
    @return_requests = current_user.return_requests.order(created_at: :desc)
  end

  def new
    @ordine = current_user.ordini.find(params[:ordine_id])
    @return_request = @ordine.return_requests.build
  end

  def create
    @ordine = current_user.ordini.find(params[:ordine_id])
    @return_request = @ordine.return_requests.build(return_request_params)
    @return_request.acquirente = current_user
  
    # Rimuoviamo gli elementi con quantità 0 o prodotti non selezionati
    @return_request.return_items.each do |item|
      unless params[:return_request][:return_items_attributes].any? { |ri| ri["prodotto_id"].to_i == item.prodotto_id && ri["quantita"].to_i > 0 }

        item.mark_for_destruction
      end
    end
  
    if @return_request.save
      redirect_to return_requests_path, notice: "Richiesta di reso inviata con successo."
    else
      render :new
    end
  end
  

  def show
  end

  def update
    if @return_request.update(stato: params[:stato])
      redirect_to return_request_path(@return_request), notice: "Stato della richiesta di reso aggiornato."
    else
      render :show
    end
  end
  
  private

  def set_return_request
    @return_request = ReturnRequest.find(params[:id])
  end

  def return_request_params
    params.require(:return_request).permit(:motivo, return_items_attributes: [:prodotto_id, :quantita])
  end
end

