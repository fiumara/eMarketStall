class AcquirentesController < ApplicationController
  before_action :set_acquirente, only: %i[ show edit update destroy ]

  # GET /acquirentes or /acquirentes.json
  def index
    @acquirentes = Acquirente.all
  end

  # GET /acquirentes/1 or /acquirentes/1.json
 def show
    @acquirente = Acquirente.find(params[:id])
    @negozio = @acquirente.negozio
  end

  # GET /acquirentes/new
  def new
    @acquirente = Acquirente.new
    @is_new = true
  end

  # GET /acquirentes/1/edit
  def edit
    @is_new = false
  end

  # POST /acquirentes or /acquirentes.json
  def create
    @acquirente = Acquirente.new(acquirente_params)
    if @acquirente.save
      redirect_to login_path, notice: 'Acquirente registrato con successo. Per favore, effettuare l\'accesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /acquirentes/1 or /acquirentes/1.json
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
  

  # DELETE /acquirentes/1 or /acquirentes/1.json
  def destroy
    @acquirente.destroy

    respond_to do |format|
      format.html { redirect_to acquirentes_url, notice: "Acquirente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acquirente
      @acquirente = Acquirente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def acquirente_params
    #  params.fetch(:acquirente, {})
    params.require(:acquirente).permit(:nome, :cognome, :nome_utente, :telefono, :email, :password, :password_confirmation, :indirizzo, :profilo_privato)
    end
end

