class ProdottosController < ApplicationController
  before_action :set_negozio, only: [:new, :create]
  before_action :set_prodotto, only: [:show, :edit, :update, :destroy]
  before_action :authorize_proprietario, only: [:destroy, :edit, :update]

  # GET /prodottos or /prodottos.json
  def index
    @prodottos = Prodotto.search(params[:search])
  end

  # GET /prodottos/1 or /prodottos/1.json
  def show
    @prodotto = Prodotto.find(params[:id])
    @promozione = @prodotto.promozione_attiva
    @prezzo_scontato = @prodotto.prezzo_scontato
    @feedbacks = @prodotto.feedbacks.includes(:acquirente)
  
    if current_user.is_a?(Acquirente)
      CronologiaRicerca.create(acquirente: current_user, prodotto: @prodotto)
  
      # Mantieni solo le ultime 50
      cronologie = CronologiaRicerca.where(acquirente: current_user).order(created_at: :desc)
      if cronologie.count > 50
        cronologie.offset(50).destroy_all
      end
    end
  end
  

  # GET /prodottos/new
  def new
    @prodotto = @negozio.prodottos.build
  end

  # GET /prodottos/1/edit
  def edit
    
  end

  # POST /prodottos or /prodottos.json
  def create
    @prodotto = @negozio.prodottos.build(prodotto_params)
    if @prodotto.save
      redirect_to @prodotto, notice: 'Prodotto creato con successo.'
    else
      render :new
    end

  end

  # PATCH/PUT /prodottos/1 or /prodottos/1.json
  def update
    respond_to do |format|
      if @prodotto.update(prodotto_params)
        format.html { redirect_to prodotto_url(@prodotto), notice: "Prodotto was successfully updated." }
        format.json { render :show, status: :ok, location: @prodotto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prodotto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prodottos/1 or /prodottos/1.json
  def destroy
    if @prodotto.ordine_items.exists?
      @prodotto.ordine_items.update_all(prodotto_id: nil)
    end
    
    @prodotto.destroy
  
    respond_to do |format|
      format.html { redirect_to negozio_path(@prodotto.negozio), notice: "Prodotto eliminato con successo." }
      format.json { head :no_content }
    end
  end
  


  def name
    self.nome_prodotto
  end 
  
  private
  def set_negozio
    @negozio = Negozio.find(params[:negozio_id])
  end

  def set_prodotto
    @prodotto = Prodotto.find(params[:id])
  end

  def authorize_proprietario
    unless @prodotto.negozio.acquirente == current_user
      redirect_to root_path, alert: "Non sei autorizzato a eliminare questo prodotto."
    end
  end
  
  

  def prodotto_params
    params.require(:prodotto).permit(:nome_prodotto, :descrizione, :prezzo, :quantita_disponibile, :categorium_id, :negozio_id, immagini: [])
  end
  
  
  
end
