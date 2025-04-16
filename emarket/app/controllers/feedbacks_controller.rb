class FeedbacksController < ApplicationController
before_action :authenticate_acquirente!

def new
  @ordine_item = OrdineItem.find(params[:ordine_item_id])
  @prodotto = @ordine_item.prodotto
  @feedback = Feedback.new
end

def create
  @ordine_item = OrdineItem.find(params[:feedback][:ordine_item_id])
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

private

def feedback_params
  params.require(:feedback).permit(:voto, :nota)
end
end

