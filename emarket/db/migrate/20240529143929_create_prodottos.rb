class CreateProdottos < ActiveRecord::Migration[6.1]
  def change
    create_table :prodottos, id: :uuid do |t|
      t.string :nome_prodotto
      t.string :descrizione
      t.float :prezzo
      t.references :negozio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
