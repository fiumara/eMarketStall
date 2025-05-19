class AddStripePaymentIntentIdToOrdini < ActiveRecord::Migration[6.1]
  def change
    add_column :ordini, :stripe_payment_intent_id, :string
  end
end
