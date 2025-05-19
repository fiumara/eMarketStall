class OrdiniController < ApplicationController
  before_action :authenticate_acquirente!

  def show
    @ordine = current_user.ordini.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to ordini_path, alert: "Ordine non trovato o non autorizzato."
  end

  def new
    @carrello = current_user.carrello
    @ordine = Ordine.new
  end

  def index
    @ordini = current_user.ordini.order(created_at: :desc)
  end

  def create
    unless params[:ordine].present? && params[:ordine][:indirizzo].present?
      redirect_to new_ordine_path, alert: "L'indirizzo è obbligatorio."
      return
    end

    carrello = current_user.carrello

    if carrello.carrello_items.empty?
      redirect_to carrello_path, alert: "Il carrello è vuoto. Aggiungi prodotti prima di procedere al pagamento."
      return
    end

    carrello.carrello_items.each do |item|
      if item.quantity > item.prodotto.quantita_disponibile
        redirect_to carrello_path, alert: "La quantità di '#{item.prodotto.nome_prodotto}' supera la disponibilità attuale (#{item.prodotto.quantita_disponibile})."
        return
      end
    end

    ordini_per_negozio = carrello.carrello_items.group_by { |item| item.prodotto.negozio }
    ordini = []
    stripe_line_items = []

    # Verifica e applica sconto fedeltà
    discount_coupon_id = nil
    use_fedelta = false

    if current_user.punti_fedelta >= 100
      coupon = Stripe::Coupon.create(
        percent_off: 10,
        duration: 'once'
      )
      discount_coupon_id = coupon.id
      current_user.decrement!(:punti_fedelta, 100)
      use_fedelta = true
    end

    ActiveRecord::Base.transaction do
      ordini_per_negozio.each do |negozio, items|
        totale = items.sum { |item| item.prodotto.prezzo_scontato * item.quantity }

        ordine = current_user.ordini.create!(
          totale: totale,
          stato: 'in_attesa',
          indirizzo: params[:ordine][:indirizzo],
          negozio: negozio,
          sconto: use_fedelta ? (totale * 0.10).round(2) : 0
        )

        items.each do |item|
          prodotto = item.prodotto
          ordine.ordine_items.create!(
            prodotto: prodotto,
            quantity: item.quantity,
            prezzo: prodotto.prezzo_scontato
          )
          nuova_quantita = [prodotto.quantita_disponibile - item.quantity, 0].max
          prodotto.update!(quantita_disponibile: nuova_quantita)
        end

        ordini << ordine

        stripe_line_items += items.map do |item|
          {
            price_data: {
              currency: 'eur',
              product_data: { name: item.prodotto.nome_prodotto },
              unit_amount: (item.prodotto.prezzo_scontato * 100).to_i
            },
            quantity: item.quantity
          }
        end
      end

      carrello.carrello_items.destroy_all
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: stripe_line_items,
      mode: 'payment',
      discounts: discount_coupon_id ? [{ coupon: discount_coupon_id }] : [],
      success_url: successo_ordini_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: errore_ordini_url,
      metadata: { ordine_id: ordini.map(&:id).join(",") }
    )

    redirect_to session.url, allow_other_host: true
  end

  def successo
    session_id = params[:session_id]

    if session_id.blank?
      redirect_to ordini_path, alert: "Errore nel pagamento, sessione non trovata."
      return
    end

    session = Stripe::Checkout::Session.retrieve(session_id)

    if session.payment_status == "paid" && session.metadata["ordine_id"]
      ordine_ids = session.metadata["ordine_id"].split(",").map(&:to_i)
      ordini = current_user.ordini.where(id: ordine_ids, stato: "in_attesa")

      if ordini.any?
        ordini.each do |ordine|
          ordine.update(
            stato: "pagato",
            stripe_payment_intent_id: session.payment_intent # 👈 salva questo valore!
          )
          assegna_punti_fedelta(ordine)
        end
        redirect_to ordini_path, notice: "Pagamento completato con successo e punti fedeltà assegnati!"
      else
        redirect_to ordini_path, alert: "Ordine non trovato o già pagato."
      end
    else
      redirect_to ordini_path, alert: "Errore nel pagamento o ordine non valido."
    end
  end

  def errore
    redirect_to carrello_path, alert: "Pagamento annullato."
  end

  def pagamento
    @ordine = current_user.ordini.find(params[:id])

    if @ordine.stato != "in_attesa"
      redirect_to @ordine, alert: "L'ordine non può essere pagato in questo stato."
      return
    end

    stripe_line_items = @ordine.ordine_items.map do |item|
      {
        price_data: {
          currency: 'eur',
          product_data: { name: item.prodotto.nome_prodotto },
          unit_amount: (item.prezzo * 100).to_i
        },
        quantity: item.quantity
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: stripe_line_items,
      mode: 'payment',
      success_url: successo_ordini_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: errore_ordini_url,
      metadata: { ordine_id: @ordine.id }
    )

    redirect_to session.url, allow_other_host: true
  end

  private

  def assegna_punti_fedelta(ordine)
    punti = (ordine.totale / 10).floor
    return if punti <= 0
    acquirente = ordine.acquirente
    acquirente.increment!(:punti_fedelta, punti)
  end
end
