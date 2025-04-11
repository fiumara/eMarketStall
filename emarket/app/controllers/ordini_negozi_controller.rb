class OrdiniNegoziController < ApplicationController
  before_action :authenticate_acquirente!
  before_action :set_negozio

  def index
    @negozio = current_user.negozio
  
    if @negozio.nil?
      redirect_to root_path, alert: "Devi avere un negozio per visualizzare gli ordini."
      return
    end
  
    # Trova gli ordini che hanno almeno un prodotto appartenente al negozio, anche se è stato eliminato
    @ordini = Ordine.joins(:ordine_items)
                    .where("ordine_items.prodotto_id IN (?) OR ordine_items.prodotto_id IS NULL", @negozio.prodottos.pluck(:id))
                    .distinct
  end
  
  

  def show
    @ordine = Ordine.find(params[:id])
  
    # Controlliamo se almeno un OrdineItem ha un prodotto del negozio, oppure se il prodotto è stato eliminato
    unless @ordine.ordine_items.any? { |item| item.prodotto.nil? || item.prodotto.negozio_id == @negozio.id }
      redirect_to negozio_ordini_path(@negozio), alert: "Non hai accesso a questo ordine."
    end
  end
  

  def update
    @ordine = Ordine.find(params[:id])

    if @ordine.update(stato: params[:stato])
      redirect_to negozio_ordine_path(@negozio, @ordine), notice: "Stato dell'ordine aggiornato."
    else
      redirect_to negozio_ordine_path(@negozio, @ordine), alert: "Errore nell'aggiornamento dello stato."
    end
  end

  private

  def set_negozio
    @negozio = current_user.negozio

    unless @negozio
      redirect_to root_path, alert: "Non hai un negozio associato!"
    end
  end
end
