class AddNomeProdottoToOrdineItems < ActiveRecord::Migration[6.1]
  def change
    add_column :ordine_items, :nome_prodotto, :string
  end
end
