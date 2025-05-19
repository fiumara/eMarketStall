class NegoziosController < ApplicationController
  before_action :authenticate_acquirente!, except: [:visualizza]
  before_action :set_negozio, only: [:show, :edit, :update, :destroy, :visualizza]

  # GET /negozios or /negozios.json
  def index
    @negozios = Negozio.all
  end

  # GET /negozios/1 or /negozios/1.json
  def show
    @acquirente = @negozio.acquirente
  end

  def visualizza
  end

  def seguaci
    @negozio = Negozio.find(params[:id])
    @seguaci = @negozio.followers
  end
  
  # GET /negozios/new
  def new
    @negozio = current_user.build_negozio
  end

  # GET /negozios/1/edit
  def edit
  end

  # POST /negozios or /negozios.json
  def create
    @negozio = current_user.build_negozio(negozio_params)
    if @negozio.save
      redirect_to @negozio, notice: 'Negozio creato con successo!'
    else
      render :new
    end
  end

  # PATCH/PUT /negozios/1 or /negozios/1.json
  def update
    respond_to do |format|
      if @negozio.update(negozio_params)
        format.html { redirect_to negozio_url(@negozio), notice: "Negozio modificato con successo." }
        format.json { render :show, status: :ok, location: @negozio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @negozio.errors, status: :unprocessable_entity }
      end
    end
  end

  def feedbacks
    @negozio = Negozio.find(params[:id])
    @prodottos = @negozio.prodottos.includes(feedbacks: :acquirente)
  end
  

  # DELETE /negozios/1 or /negozios/1.json
  def destroy
    @negozio.destroy

    respond_to do |format|
      format.html { redirect_to negozios_url, notice: "Negozio cancellato con successo." }
      format.json { head :no_content }
    end
  end

  def statistiche
    @negozio = Negozio.find(params[:id])
    prodotti = @negozio.prodottos.includes(:ordine_items)
  
    ordine_items = prodotti.flat_map(&:ordine_items)
  
    # Statistiche generali
    @totale_vendite = ordine_items.sum(&:quantity)
    @guadagni_ultimo_mese = ordine_items.select { |oi| oi.created_at >= 1.month.ago }.sum { |oi| oi.quantity * oi.prezzo }
    @guadagni_ultimo_anno = ordine_items.select { |oi| oi.created_at >= 1.year.ago }.sum { |oi| oi.quantity * oi.prezzo }
    @prodotti_in_vendita = prodotti.count
    @media_prezzo = (@negozio.prodottos.average(:prezzo) || 0).to_f

  
    # Statistiche per prodotto
    @statistiche_per_prodotto = prodotti.map do |p|
      items = p.ordine_items
      {
        prodotto: p,
        venduti: items.sum(:quantity),
        disponibili: p.quantita_disponibile,
        venduti_ultimo_mese: items.where(created_at: 1.month.ago..Time.current).sum(:quantity),
        venduti_ultimo_anno: items.where(created_at: 1.year.ago..Time.current).sum(:quantity)
      }
    end
  end
  
  def segnala_form
    @negozio = Negozio.find(params[:id])
  end
  
  def segnala
    @negozio = Negozio.find(params[:id])
    @segnalazione = SegnalazioneNegozio.new(
      motivo: params[:motivo],
      note: params[:note],
      acquirente: current_user,
      negozio: @negozio
    )
  
    if @segnalazione.save
      redirect_to visualizza_negozio_path(@negozio), notice: "Segnalazione inviata con successo."
    else
      render :segnala_form, alert: "Errore nell'invio della segnalazione."
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_negozio
      @negozio = Negozio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def negozio_params
      params.require(:negozio).permit(:nome_negozio, :descrizione, :indirizzo, :telefono, :immagine)
    end
end
