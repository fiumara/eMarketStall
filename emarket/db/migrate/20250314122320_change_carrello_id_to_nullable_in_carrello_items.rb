class ChangeCarrelloIdToNullableInCarrelloItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :carrello_items, :carrello_id, true
  end
end
