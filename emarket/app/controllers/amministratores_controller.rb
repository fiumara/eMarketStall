class AmministratoresController < ApplicationController
  before_action :set_amministratore, only: %i[ show edit update destroy ]
  before_action :authenticate_amministratore!, only: %i[ show edit update destroy ]
  before_action :authorize_amministratore, only: %i[ show edit update destroy ]

  # GET /amministratores or /amministratores.json
  def index
    @amministratores = Amministratore.all
  end

  # GET /amministratores/1 or /amministratores/1.json
  def show
    @amministratore = Amministratore.find(params[:id])
  end

  # GET /amministratores/new
  def new
    @amministratore = Amministratore.new
  end

  # GET /amministratores/1/edit
  def edit
  end

  # POST /amministratores or /amministratores.json
  def create
    @amministratore = Amministratore.new(amministratore_params)

    if @amministratore.save
      session[:user_id] = @amministratore.id
      session[:role] = 'amministratore'
      redirect_to root_path, notice: "Registrazione completata!"
    else
      render :new
    end

    respond_to do |format|
      if @amministratore.save
        format.html { redirect_to amministratore_url(@amministratore), notice: "Amministratore was successfully created." }
        format.json { render :show, status: :created, location: @amministratore }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @amministratore.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amministratores/1 or /amministratores/1.json
  def update
    respond_to do |format|
      if @amministratore.update(amministratore_params)
        format.html { redirect_to @amministratore, notice: "Amministratore aggiornato con successo." }
        format.json { render :show, status: :ok, location: @amministratore }
      else
        format.html { render :edit }
        format.json { render json: @amministratore.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amministratores/1 or /amministratores/1.json
  def destroy
    @amministratore.destroy

    respond_to do |format|
      format.html { redirect_to amministratores_url, notice: "Amministratore was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def feedbacks_segnalati
    @feedbacks = Feedback.where(segnalato: true).includes(:acquirente, :prodotto)
  end

  def statistiche
    @acquirenti_totali = Acquirente.count
    @venditori_totali = Negozio.count
  
    @acquirenti_corrente_mese = Acquirente.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).count
    @venditori_corrente_mese = Negozio.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).count
  
    @acquirenti_corrente_anno = Acquirente.where(created_at: Time.current.beginning_of_year..Time.current.end_of_year).count
    @venditori_corrente_anno = Negozio.where(created_at: Time.current.beginning_of_year..Time.current.end_of_year).count
  
    @vendite_totali = Ordine.count
    @media_acquisti_per_acquirente = Ordine.group(:acquirente_id).count.values.sum.to_f / Acquirente.count rescue 0
  
    @media_articoli_per_ordine = Ordine.joins(:ordine_items).group(:id).count.values.sum.to_f / Ordine.count rescue 0
  
    acquirenti_con_almeno_un_ordine = Acquirente.joins(:ordini).distinct.count
    acquirenti_senza_ordini = Acquirente.count - acquirenti_con_almeno_un_ordine
    @rapporto_acquirenti_0_vs_1plus = {
      con_ordini: acquirenti_con_almeno_un_ordine,
      senza_ordini: acquirenti_senza_ordini
    }
  
    @media_prodotti_per_venditore = Negozio.joins(:prodottos).group(:id).count.values.sum.to_f / Negozio.count rescue 0
  
    @media_guadagno_per_venditore = Negozio.all.map do |negozio|
      negozio.prodottos.joins(:ordine_items).sum("ordine_items.prezzo * ordine_items.quantity")
    end.sum.to_f / Negozio.count rescue 0
  
    @media_spesa_per_acquirente = Acquirente.all.map do |acq|
      acq.ordini.joins(:ordine_items).sum("ordine_items.prezzo * ordine_items.quantity")
    end.sum.to_f / Acquirente.count rescue 0
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amministratore
      @amministratore = Amministratore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def amministratore_params
    #  params.fetch(:amministratore, {})
    params.require(:amministratore).permit(:nome, :cognome, :email, :password, :password_confirmation)
    end

    def authorize_amministratore
      unless current_user == @amministratore
        redirect_to root_path, alert: "Accesso negato: non sei autorizzato ad accedere a questa pagina." and return
      end
    end
end