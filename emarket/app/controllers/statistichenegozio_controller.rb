class StatistichenegozioController < ApplicationController
  def index
    @negozio = Negozio.find(params[:id])
    if params[:query].present?
      @prodotti = @negozio.prodottos.where('nome_prodotto LIKE ?', "%#{params[:query]}%")
    else
      @prodotti = @negozio.prodottos
    end
  end
end
