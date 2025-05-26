class PromozionesController < ApplicationController
    before_action :set_promozione, only: %i[show edit update destroy]
    
    before_action :authorize_negozio_or_admin, only: %i[create new edit update destroy]

    before_action :authorize_promozione_owner, only: %i[edit update destroy]

  
    # GET /promoziones or /promoziones.json
    def index
      @promoziones = Promozione.all
    end
  
    # GET /promoziones/1 or /promoziones/1.json
    def show
    end

    def admin
      @promoziones = Promozione.where(created_by: 'admin')
    end

    def negozio
      @promoziones = Promozione.where(negozio: current_user.negozio)
    end
  
    # GET /promoziones/new
    def new
      @promozione = Promozione.new
    end
  
    # GET /promoziones/1/edit
    def edit
    end
  
    # POST /promoziones or /promoziones.json
    def create
      @promozione = Promozione.new(promozione_params)
      if current_user.is_a?(Acquirente) && current_user.negozio.present?
           @promozione.negozio = current_user.negozio
           @promozione.created_by = 'negozio'
            @promozione.tipo = 'singolo_prodotto'
          elsif current_user.is_a?(Amministratore)
            @promozione.created_by = 'admin'
          end
        
  
      respond_to do |format|
        if @promozione.save
          format.html { redirect_to @promozione, notice: 'Promozione creata con successo.' }
          format.json { render :show, status: :created, location: @promozione }
        else
          format.html { render :new }
          format.json { render json: @promozione.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /promoziones/1 or /promoziones/1.json
    def update
      respond_to do |format|
        if @promozione.update(promozione_params)
          format.html { redirect_to @promozione, notice: 'Promozione aggiornata con successo.' }
          format.json { render :show, status: :ok, location: @promozione }
        else
          format.html { render :edit }
          format.json { render json: @promozione.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /promoziones/1 or /promoziones/1.json
    def destroy
      @promozione.destroy
      respond_to do |format|
        format.html { redirect_to promoziones_url, notice: 'Promozione eliminata con successo.' }
        format.json { head :no_content }
      end
    end
  
    private
  
    def set_promozione
      @promozione = Promozione.find(params[:id])
    end
  
    def promozione_params
      params.require(:promozione).permit(:nome, :descrizione, :inizio, :fine, :sconto, :tipo, :prodotto_id, :categorium_id)
    end
  
    def authorize_negozio_or_admin
      unless current_user.is_a?(Amministratore) || (current_user.is_a?(Acquirente) && current_user.negozio.present?)
        redirect_to root_path, alert: 'Accesso negato: questa pagina è riservata agli amministratori o ai negozi.'
      end
    end

    def authorize_promozione_owner
      if @promozione.created_by == 'negozio'
        unless current_user.is_a?(Acquirente) && current_user.negozio == @promozione.negozio
          redirect_to root_path, alert: 'Non sei autorizzato a modificare questa promozione.'
        end
      elsif @promozione.created_by == 'admin'
        unless current_user.is_a?(Amministratore)
          redirect_to root_path, alert: 'Solo un amministratore può modificare questa promozione.'
        end
      else
        redirect_to root_path, alert: 'Accesso non autorizzato.'
      end
    end
    
  end
  
