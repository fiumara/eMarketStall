class AmministratoresController < ApplicationController
  before_action :set_amministratore, only: %i[ show edit update destroy ]

  # GET /amministratores or /amministratores.json
  def index
    @amministratores = Amministratore.all
  end

  # GET /amministratores/1 or /amministratores/1.json
  def show
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
        format.html { redirect_to amministratore_url(@amministratore), notice: "Amministratore was successfully updated." }
        format.json { render :show, status: :ok, location: @amministratore }
      else
        format.html { render :edit, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amministratore
      @amministratore = Amministratore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def amministratore_params
      params.fetch(:amministratore, {})
    end
end
