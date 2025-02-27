class MakeOrdineIdNotNullInCarrelloItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :carrello_items, :ordine_id, false
  end
end
