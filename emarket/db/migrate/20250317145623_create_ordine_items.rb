class CreateOrdineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :ordine_items do |t|
      t.references :ordine, null: false, foreign_key: true
      t.references :prodotto, foreign_key: { on_delete: :nullify }
      t.integer :quantity, null: false
      t.decimal :prezzo, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
