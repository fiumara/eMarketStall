class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.references :acquirente, null: false, foreign_key: { on_delete: :nullify }
      t.references :prodotto, null: false, foreign_key: { on_delete: :cascade }
      t.references :ordine_item, null: false, foreign_key: { on_delete: :cascade }
      t.integer :voto
      t.text :nota

      t.timestamps
    end
  end
end
