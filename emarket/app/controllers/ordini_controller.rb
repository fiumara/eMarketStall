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
    
      totale = carrello.carrello_items.sum { |item| item.prodotto.prezzo * item.quantity }
    
      ordine = current_user.ordini.create!(
        totale: totale,
        stato: 'in_attesa',
        indirizzo: params[:ordine][:indirizzo]
      )
    
      # 🔥 **IMPORTANTE**: Associa i carrello_items all'ordine
      carrello.carrello_items.update_all(ordine_id: ordine.id)
    
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: carrello.carrello_items.map do |item|
          {
            price_data: {
              currency: 'eur',
              product_data: { name: item.prodotto.nome_prodotto },
              unit_amount: (item.prodotto.prezzo * 100).to_i
            },
            quantity: item.quantity
          }
        end,
        mode: 'payment',
        success_url: successo_ordini_url,
        cancel_url: errore_ordini_url
      )
    
      redirect_to session.url, allow_other_host: true
    end
    
    
  
    def successo
      # Trova l'ordine in attesa e aggiorna lo stato
      ordine = current_user.ordini.in_attesa.last
      ordine.update(stato: 'pagato') if ordine
  
      redirect_to root_path, notice: "Pagamento completato con successo!"
    end
  
    def errore
      redirect_to carrello_path, alert: "Pagamento annullato."
    end
  end
  
