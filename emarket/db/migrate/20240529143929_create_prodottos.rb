class CreateProdottos < ActiveRecord::Migration[6.1]
  def change
    create_table :prodottos, id: false do |t|
      t.integer :id, primary_key: true
      t.string :nome_prodotto
      t.string :descrizione
      t.float :prezzo
      t.references :negozio, null: false, foreign_key: true
      t.references :categorium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
