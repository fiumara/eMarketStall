class CronologiaRicercheController < ApplicationController
  before_action :authenticate_acquirente!

  def index
    @prodotti_visualizzati = CronologiaRicerca
      .where(acquirente: current_user)
      .includes(:prodotto)
      .order(created_at: :desc)
      .limit(50)
      .map(&:prodotto)
  end
end
