class GestioneAccountController < ApplicationController
  before_action :authenticate_amministratore!

  def manage
    @acquirente = Acquirente.all
  
    if params[:search].present?
      @acquirente = @acquirente.where("LOWER(nome) LIKE ? OR LOWER(cognome) LIKE ? OR LOWER(nome_utente) LIKE ?", 
                                       "%#{params[:search].downcase}%", 
                                       "%#{params[:search].downcase}%", 
                                       "%#{params[:search].downcase}%")
    end
  
    case params[:user_type]
    when "acquirente"
      @acquirente = @acquirente.select { |a| a.negozio.blank? }
    when "venditore"
      @acquirente = @acquirente.select { |a| a.negozio.present? }
    end
  end
  
  

  def blocca
    acquirente = Acquirente.find(params[:id])
    acquirente.bloccato = true
  
    if acquirente.save
      redirect_to gestione_account_path, notice: "Utente bloccato con successo."
    else
      logger.error "Errore nel bloccare l'utente: #{acquirente.errors.full_messages.join(", ")}"
      redirect_to gestione_account_path, alert: "Errore nel bloccare l'utente."
    end
  end
  
  
  def sblocca
    acquirente = Acquirente.find(params[:id])
    acquirente.update(bloccato: false)
    redirect_to gestione_account_path, notice: "Utente sbloccato con successo"
  end
  
  def elimina
    acquirente = Acquirente.find(params[:id])
  
    # Se l'acquirente ha un negozio, lo eliminiamo
    if acquirente.negozio.present?
      acquirente.negozio.destroy
    end
  
    # Elimina i messaggi dell'acquirente
    Messaggio.where(mittente_type: "Acquirente", mittente_id: acquirente.id).destroy_all
    Messaggio.where(destinatario_type: "Acquirente", destinatario_id: acquirente.id).destroy_all
  
    # Elimina le recensioni dell'acquirente (se esistono)
    acquirente.recensioni.destroy_all if acquirente.respond_to?(:recensioni)
  
    # Ora elimina l'acquirente
    acquirente.destroy
  
    redirect_to gestione_account_path, notice: "Utente e negozio eliminati con successo"
  end
  
  
  
  
end