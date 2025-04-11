class CreateOrdini < ActiveRecord::Migration[6.1]
  def change
    create_table :ordini do |t|
      t.references :acquirente, null: false, foreign_key: { on_delete: :cascade }
      t.string :codice_ordine, null: false
      t.decimal :totale
      t.string :stato
      t.string :indirizzo

      t.timestamps
    end

    add_index :ordini, :codice_ordine, unique: true
  end
end
