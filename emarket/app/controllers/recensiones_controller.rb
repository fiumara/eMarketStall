class RecensionesController < ApplicationController
  before_action :set_recensione, only: %i[ show edit update destroy ]

  # GET /recensiones or /recensiones.json
  def index
    @recensiones = Recensione.all
  end

  # GET /recensiones/1 or /recensiones/1.json
  def show
  end

  # GET /recensiones/new
  def new
    @recensione = Recensione.new
  end

  # GET /recensiones/1/edit
  def edit
  end

  # POST /recensiones or /recensiones.json
  def create
    @recensione = Recensione.new(recensione_params)

    respond_to do |format|
      if @recensione.save
        format.html { redirect_to recensione_url(@recensione), notice: "Recensione was successfully created." }
        format.json { render :show, status: :created, location: @recensione }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recensione.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recensiones/1 or /recensiones/1.json
  def update
    respond_to do |format|
      if @recensione.update(recensione_params)
        format.html { redirect_to recensione_url(@recensione), notice: "Recensione was successfully updated." }
        format.json { render :show, status: :ok, location: @recensione }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recensione.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recensiones/1 or /recensiones/1.json
  def destroy
    @recensione.destroy

    respond_to do |format|
      format.html { redirect_to recensiones_url, notice: "Recensione was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recensione
      @recensione = Recensione.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recensione_params
      params.fetch(:recensione, {})
    end
end
