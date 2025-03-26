class GestioneAccountController < ApplicationController
  before_action :authenticate_amministratore!

  def manage
    @acquirente = Acquirente.all
  end

  def blocca
    acquirente = Acquirente.find(params[:id])
    acquirente.update(bloccato: true)
    redirect_to gestione_account_path, notice: "Utente bloccato con successo"
  end
  
  def sblocca
    acquirente = Acquirente.find(params[:id])
    acquirente.update(bloccato: false)
    redirect_to gestione_account_path, notice: "Utente sbloccato con successo"
  end
  
  def elimina
    acquirente = Acquirente.find(params[:id])
    acquirente.destroy
    redirect_to gestione_account_path, notice: "Utente eliminato con successo"
  end
  
end

      
      
