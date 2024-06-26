class FaqsController < ApplicationController
  before_action :authenticate_acquirente!, only: [:index]
  before_action :authenticate_amministratore!, except: [:index]
  before_action :set_faq, only: [:show, :edit, :update, :destroy]

  def index
    @faqs = Faq.all
  end

  def admin
    @faqs = Faq.all
  end

  def show
  end

  def new
    @faq = Faq.new
  end

  def edit
  end

  def create
    @faq = Faq.new(faq_params)
    if @faq.save
      redirect_to admin_faqs_path, notice: 'FAQ was successfully created.'
    else
      render :new
    end
  end

  def update
    if @faq.update(faq_params)
      redirect_to admin_faqs_path, notice: 'FAQ was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @faq.destroy
    redirect_to admin_faqs_path, notice: 'FAQ was successfully destroyed.'
  end

  private

  def set_faq
    Rails.logger.debug("Params: #{params.inspect}")
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:domanda, :risposta)
  end
end
