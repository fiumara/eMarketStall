class CreateWishlistItems < ActiveRecord::Migration[6.1]
  def change
    create_table :wishlist_items do |t|
      t.references :acquirente, null: false, foreign_key: { on_delete: :cascade }
      t.references :prodotto, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :wishlist_items, [:acquirente_id, :prodotto_id], unique: true
  end
end
