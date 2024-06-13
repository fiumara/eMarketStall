class ProdottosController < ApplicationController
  before_action :set_negozio, only: [:new, :create]

  # GET /prodottos or /prodottos.json
  def index
    @prodottos = Prodotto.all
  end

  # GET /prodottos/1 or /prodottos/1.json
  def show
    @prodotto = @prodotto = Prodotto.find(params[:id])
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
      redirect_to @negozio, notice: 'Prodotto creato con successo.'
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
    @prodotto.destroy

    respond_to do |format|
      format.html { redirect_to prodottos_url, notice: "Prodotto was successfully destroyed." }
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

  def prodotto_params
    params.require(:prodotto).permit(:nome_prodotto, :descrizione, :prezzo)
  end
end
