class ListaDesideriController < ApplicationController
  before_action :authenticate_user!

  def index
    @wishlist = current_user.wishlist
  end

  def add
    @prodotto = Prodotto.find(params[:id])
    if current_user.wishlist.include?(@prodotto)
      notice = 'Il prodotto è già nella lista desideri.'
    else
      current_user.wishlist << @prodotto
      notice = 'Prodotto aggiunto alla lista desideri.'
    end

    redirect_back(fallback_location: root_path, notice: notice)
  end

  def remove
    @prodotto = Prodotto.find(params[:id])
    if current_user.wishlist.delete(@prodotto)
      notice = 'Prodotto rimosso dalla lista desideri.'
    else
      notice = 'Impossibile rimuovere il prodotto dalla lista desideri.'
    end

    redirect_to lista_desideri_path, notice: notice
  end
end
