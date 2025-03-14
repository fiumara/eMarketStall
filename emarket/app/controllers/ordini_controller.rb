class OrdiniController < ApplicationController
    before_action :authenticate_acquirente!

    def show
      @ordine = current_user.ordini.find(params[:id]) # Evita che un utente veda ordini di altri
    rescue ActiveRecord::RecordNotFound
      redirect_to ordini_path, alert: "Ordine non trovato o non autorizzato."
    end
    

    def new
      @carrello = current_user.carrello
      @ordine = Ordine.new
    end

    def index
      
      @ordini = current_user.ordini.order(created_at: :desc) # Ordina dal più recente al più vecchio
    end
    
  
    def create
      unless params[:ordine].present? && params[:ordine][:indirizzo].present?
        redirect_to new_ordine_path, alert: "L'indirizzo è obbligatorio."
        return
      end
    
      carrello = current_user.carrello
      if carrello.carrello_items.empty?
        redirect_to carrello_path, alert: "Il carrello è vuoto. Aggiungi prodotti prima di procedere al pagamento."
        return
      end
    
      # 📌 Raggruppiamo i carrello_items per negozio
      ordini_per_negozio = carrello.carrello_items.group_by { |item| item.prodotto.negozio }
    
      ordini = [] # Array per salvare tutti gli ordini creati
      stripe_line_items = [] # Array per i prodotti da inviare a Stripe
    
      ActiveRecord::Base.transaction do
        ordini_per_negozio.each do |negozio, items|
          totale = items.sum { |item| item.prodotto.prezzo * item.quantity }
      
          ordine = current_user.ordini.create!(
            totale: totale,
            stato: 'in_attesa',
            indirizzo: params[:ordine][:indirizzo],
            negozio: negozio
          )
      
          # 📌 Associa i prodotti all'ordine
          items.each { |item| item.update!(ordine_id: ordine.id) }
   
      
          ordini << ordine
      
          stripe_line_items += items.map do |item|
            {
              price_data: {
                currency: 'eur',
                product_data: { name: item.prodotto.nome_prodotto },
                unit_amount: (item.prodotto.prezzo * 100).to_i
              },
              quantity: item.quantity
            }
          end
        end
      
        # 📌 Rimuove i carrello_items che sono stati già assegnati agli ordini
        carrello.carrello_items.update_all(carrello_id: nil)


      end
      
    
      # 📌 Creiamo la sessione di pagamento per tutti i prodotti
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: stripe_line_items,
        mode: 'payment',
        success_url: successo_ordini_url,
        cancel_url: errore_ordini_url
      )
    
      redirect_to session.url, allow_other_host: true
    end
    
    
  
    def successo
      # Trova tutti gli ordini in attesa dell'utente e li imposta come 'pagato'
      current_user.ordini.in_attesa.update_all(stato: 'pagato')
    
      redirect_to root_path, notice: "Pagamento completato con successo!"
    end
  
    def errore
      redirect_to carrello_path, alert: "Pagamento annullato."
    end
  end
  
