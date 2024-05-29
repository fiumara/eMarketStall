class NegoziosController < ApplicationController
  before_action :set_negozio, only: %i[ show edit update destroy ]

  # GET /negozios or /negozios.json
  def index
    @negozios = Negozio.all
  end

  # GET /negozios/1 or /negozios/1.json
  def show
  end

  # GET /negozios/new
  def new
    @negozio = Negozio.new
  end

  # GET /negozios/1/edit
  def edit
  end

  # POST /negozios or /negozios.json
  def create
    @negozio = Negozio.new(negozio_params)

    respond_to do |format|
      if @negozio.save
        format.html { redirect_to negozio_url(@negozio), notice: "Negozio was successfully created." }
        format.json { render :show, status: :created, location: @negozio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @negozio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /negozios/1 or /negozios/1.json
  def update
    respond_to do |format|
      if @negozio.update(negozio_params)
        format.html { redirect_to negozio_url(@negozio), notice: "Negozio was successfully updated." }
        format.json { render :show, status: :ok, location: @negozio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @negozio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /negozios/1 or /negozios/1.json
  def destroy
    @negozio.destroy

    respond_to do |format|
      format.html { redirect_to negozios_url, notice: "Negozio was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_negozio
      @negozio = Negozio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def negozio_params
      params.fetch(:negozio, {})
    end
end
