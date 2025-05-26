class FeedbacksController < ApplicationController
before_action :authenticate_acquirente!
before_action :set_feedback, only: [:segnala]

def new
  @ordine_item = OrdineItem.find(params[:ordine_item_id])

  if @ordine_item.ordine.acquirente != current_user
    redirect_to root_path, alert: "Non sei autorizzato ad accedere a questo feedback." and return
  end

  @prodotto = @ordine_item.prodotto
  @feedback = Feedback.new
end


def create
  @ordine_item = OrdineItem.find(params[:feedback][:ordine_item_id])

  # 🔒 Verifica che l'acquirente sia il proprietario dell'ordine
  if @ordine_item.ordine.acquirente != current_user
    redirect_to root_path, alert: "Non sei autorizzato a lasciare un feedback per questo prodotto." and return
  end

  @feedback = Feedback.new(feedback_params)
  @feedback.acquirente = current_user
  @feedback.prodotto = @ordine_item.prodotto
  @feedback.ordine_item = @ordine_item

  if @feedback.save
    redirect_to prodotto_path(@feedback.prodotto), notice: "Feedback inviato!"
  else
    render :new
  end
end


def segnala
  @feedback.segnalato = true
  if @feedback.save
    redirect_back fallback_location: root_path, notice: "Feedback segnalato. Verrà revisionato da un amministratore."
  else
    redirect_back fallback_location: root_path, alert: "Errore nella segnalazione del feedback."
  end
end

def destroy
  @feedback = Feedback.find(params[:id])
  @feedback.destroy
  redirect_to params[:redirect_to] || admin_feedbacks_segnalati_path, notice: "Feedback eliminato con successo."
end

def ignora_segnalazione
  @feedback = Feedback.find(params[:id])
  @feedback.update(segnalato: false)
  redirect_to admin_feedbacks_segnalati_path, notice: "Segnalazione ignorata."
end


private

def feedback_params
  params.require(:feedback).permit(:voto, :nota)
end

def set_feedback
  @feedback = Feedback.find(params[:id])
end
end

