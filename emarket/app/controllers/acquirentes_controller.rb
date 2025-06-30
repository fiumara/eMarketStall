class AcquirentesController < ApplicationController
  before_action :set_acquirente, only: %i[ show edit update destroy ]
  before_action :authenticate_acquirente!, only: %i[ show edit update destroy ]
  before_action :authorize_acquirente, only: %i[ show edit update destroy ]

  
  


 def show
    @acquirente = Acquirente.find(params[:id])
    @negozio = @acquirente.negozio
  end


  def new
    @acquirente = Acquirente.new
    @is_new = true
  end

  
  def edit
    @is_new = false
  end


  def create
    @acquirente = Acquirente.new(acquirente_params)
    if @acquirente.save
      messaggio = "Acquirente registrato con successo. Per favore, effettuare l\'accesso."
      messaggio_tradotto = TranslationService.translate(messaggio, session[:lingua] || "it")
      redirect_to login_path, notice: messaggio_tradotto

    else
      render :new
    end
  end

  
  def update
    respond_to do |format|
      if @acquirente.update(acquirente_params)
        format.html { redirect_to @acquirente, notice: "Acquirente aggiornato con successo." }
        format.json { render :show, status: :ok, location: @acquirente }
      else
        format.html { render :edit }
        format.json { render json: @acquirente.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def visualizza
    @acquirente = Acquirente.find(params[:id])
  
    if current_user.is_a?(Amministratore) || 
   (current_user.is_a?(Acquirente) && current_user == @acquirente) || 
   !@acquirente.privato
  @profilo_limitato = false
else
  @profilo_limitato = true
end

  end
  

  def seguiti
    @negozi_seguiti = current_user.negozi_seguiti
  end
  
  
  def destroy
    @acquirente.destroy

    respond_to do |format|
      messaggio = "Acquirente was successfully destroyed."
      messaggio_tradotto = TranslationService.translate(messaggio, session[:lingua] || "it")

      format.html { redirect_to login_path, notice: messaggio_tradotto }
      format.json { head :no_content }
    end
  end

  private

    def set_acquirente
      @acquirente = Acquirente.find(params[:id])
    end

  
    def acquirente_params
  
    params.require(:acquirente).permit(:nome, :cognome, :nome_utente, :telefono, :email, :password, :password_confirmation, :indirizzo, :privato)
    end

    def authorize_acquirente
      puts "🔹 Controllo autorizzazione per #{current_user&.id} vs #{@acquirente.id}"
      unless current_user == @acquirente
        messaggio = "Accesso negato: non sei autorizzato ad accedere a questa pagina."
        messaggio_tradotto = TranslationService.translate(messaggio, session[:lingua] || "it")
        redirect_to root_path, alert: messaggio_tradotto and return
      end
    end
end

