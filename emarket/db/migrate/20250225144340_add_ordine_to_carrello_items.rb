class AddOrdineToCarrelloItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :carrello_items, :ordine, foreign_key: true, null: true
  end
end
