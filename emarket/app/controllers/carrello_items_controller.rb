class CarrelloItemsController < ApplicationController
    before_action :authenticate_acquirente!
  
    def create
        # Trova o crea il carrello per l'utente corrente
        carrello = current_user.carrello || current_user.create_carrello
    
        prodotto = Prodotto.find(params[:prodotto_id])
        carrello_item = carrello.carrello_items.find_by(prodotto: prodotto)
    
        if carrello_item
          # Se il prodotto è già nel carrello, aggiorna la quantità
          carrello_item.update(quantity: carrello_item.quantity + params[:quantity].to_i)
        else
          # Aggiungi un nuovo elemento al carrello
          carrello.carrello_items.create(prodotto: prodotto, quantity: params[:quantity])
        end
    
        redirect_to carrello_path, notice: "#{prodotto.nome_prodotto} aggiunto al carrello!"
      end
    def destroy
      carrello_item = CarrelloItem.find(params[:id])
      carrello_item.destroy
  
      redirect_to carrello_path, notice: "Elemento rimosso dal carrello."
    end
  end
  
