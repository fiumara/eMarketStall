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

    # Se l'acquirente ha un negozio, chiama la funzione nel NegoziosController
    if acquirente.negozio.present?
      redirect_to elimina_gestione_account_path(acquirente.id) and return
    end

    # Elimina i messaggi dell'acquirente
    Messaggio.where(mittente_type: "Acquirente", mittente_id: acquirente.id).destroy_all
    Messaggio.where(destinatario_type: "Acquirente", destinatario_id: acquirente.id).destroy_all

    # Elimina le recensioni dell'acquirente (se esistono)
    acquirente.recensioni.destroy_all if acquirente.respond_to?(:recensioni)

    # Ora elimina l'acquirente
    acquirente.destroy

    redirect_to gestione_account_path, notice: "Utente eliminato con successo"
  end
  
  
  
  
end
      
      
