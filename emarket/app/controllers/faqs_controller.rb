class FaqsController < ApplicationController
  before_action :set_faq, only: [:edit, :update, :destroy]

  def index
    @faqs = Faq.all
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new(faq_params)
    if @faq.save
      redirect_to faqs_path, notice: 'FAQ creata con successo.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @faq.update(faq_params)
      redirect_to faqs_path, notice: 'FAQ aggiornata con successo.'
    else
      render :edit
    end
  end

  def destroy
    @faq.destroy
    redirect_to faqs_path, notice: 'FAQ eliminata con successo.'
  end

  private

  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:domanda, :risposta)
  end
  def show
  end
end
