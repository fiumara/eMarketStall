class HomeController < ApplicationController
  def index
    @promoziones = Promozione.limit(3)
    @prodottos = Prodotto.all
  end
end
