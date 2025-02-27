class ChangeOrdineIdNullInCarrelloItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :carrello_items, :ordine_id, true
  end
end
