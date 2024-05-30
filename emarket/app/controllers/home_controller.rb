class HomeController < ApplicationController
  def index
    @prodottos = Prodotto.all
  end
end
