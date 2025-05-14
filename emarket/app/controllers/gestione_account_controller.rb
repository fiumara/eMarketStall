class GestioneAccountController < ApplicationController
  before_action :authenticate_amministratore!

  def manage
    case params[:user_type]
    when 'acquirente'
      @acquirente = Acquirente.left_outer_joins(:negozio).where(negozios: { id: nil })
    when 'venditore'
      @acquirente = Acquirente.joins(:negozio)
    when 'segnalati'
      @segnalazioni = SegnalazioneNegozio.includes(:negozio, :acquirente).all
      negozi_segnalati_ids = SegnalazioneNegozio.select(:negozio_id).distinct.pluck(:negozio_id)
      @acquirente = Acquirente.joins(:negozio).where(negozios: { id: negozi_segnalati_ids })
    else
      # tutti gli acquirenti, con o senza negozio
      @acquirente = Acquirente.all
    end
  
    if params[:search].present?
      query = "%#{params[:search].downcase}%"
      @acquirente = @acquirente.where(
        "LOWER(nome) LIKE :query OR LOWER(cognome) LIKE :query OR LOWER(nome_utente) LIKE :query",
        query: query
      )
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
  
  def elimina_negozio
    acquirente = Acquirente.find(params[:id])
    acquirente.negozio.destroy
    redirect_to gestione_account_path, notice: "Negozio eliminati con successo"
  end 
  
  def ignora_segnalazione_negozio
    segnalazione = SegnalazioneNegozio.find(params[:id])
    segnalazione.destroy
    redirect_to gestione_account_index_path, notice: 'Segnalazione ignorata con successo.'
  end
  
  
  
end