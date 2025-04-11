class CreateCarrelloItems < ActiveRecord::Migration[6.1]
  def change
    create_table :carrello_items do |t|
      t.references :carrello, null: false, foreign_key: { on_delete: :cascade }
      t.references :prodotto, null: false, foreign_key: { on_delete: :cascade }
      t.references :ordine, foreign_key: { on_delete: :cascade }, null: true 
      
      t.integer :quantity

      t.timestamps
    end
  end
end
