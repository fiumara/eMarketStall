class ProdottosController < ApplicationController
  before_action :set_prodotto, only: %i[ show edit update destroy ]

  # GET /prodottos or /prodottos.json
  def index
    @prodottos = Prodotto.all
  end

  # GET /prodottos/1 or /prodottos/1.json
  def show
  end

  # GET /prodottos/new
  def new
    @prodotto = Prodotto.new
  end

  # GET /prodottos/1/edit
  def edit
  end

  # POST /prodottos or /prodottos.json
  def create
    @prodotto = Prodotto.new(prodotto_params)

    respond_to do |format|
      if @prodotto.save
        format.html { redirect_to prodotto_url(@prodotto), notice: "Prodotto was successfully created." }
        format.json { render :show, status: :created, location: @prodotto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prodotto.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prodotto
      @prodotto = Prodotto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prodotto_params
      params.fetch(:prodotto, {})
    end
end
