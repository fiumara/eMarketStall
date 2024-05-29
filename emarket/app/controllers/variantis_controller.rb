class VariantisController < ApplicationController
  before_action :set_varianti, only: %i[ show edit update destroy ]

  # GET /variantis or /variantis.json
  def index
    @variantis = Varianti.all
  end

  # GET /variantis/1 or /variantis/1.json
  def show
  end

  # GET /variantis/new
  def new
    @varianti = Varianti.new
  end

  # GET /variantis/1/edit
  def edit
  end

  # POST /variantis or /variantis.json
  def create
    @varianti = Varianti.new(varianti_params)

    respond_to do |format|
      if @varianti.save
        format.html { redirect_to varianti_url(@varianti), notice: "Varianti was successfully created." }
        format.json { render :show, status: :created, location: @varianti }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @varianti.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variantis/1 or /variantis/1.json
  def update
    respond_to do |format|
      if @varianti.update(varianti_params)
        format.html { redirect_to varianti_url(@varianti), notice: "Varianti was successfully updated." }
        format.json { render :show, status: :ok, location: @varianti }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @varianti.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variantis/1 or /variantis/1.json
  def destroy
    @varianti.destroy

    respond_to do |format|
      format.html { redirect_to variantis_url, notice: "Varianti was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_varianti
      @varianti = Varianti.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def varianti_params
      params.fetch(:varianti, {})
    end
end
