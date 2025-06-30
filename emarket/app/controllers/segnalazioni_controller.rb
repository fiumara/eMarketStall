class SegnalazioniController < ApplicationController
    before_action :authenticate_admin! 
  
    def index
      @segnalazioni = SegnalazioneNegozio.includes(:negozio, :acquirente).all
    end
  
    def destroy
      @segnalazione = SegnalazioneNegozio.find(params[:id])
      @segnalazione.destroy
      redirect_to gestione_account_path, notice: "Segnalazione ignorata."
    end
  end
  