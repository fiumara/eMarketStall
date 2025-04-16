class ChangeProdottoIdNullInOrdineItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :ordine_items, :prodotto_id, true
  end
end
