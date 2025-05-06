class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :acquirente, null: false, foreign_key:{on_delete: :cascade}
      t.references :negozio, null: false, foreign_key:{on_delete: :cascade}

      t.timestamps
    end
  end
end
