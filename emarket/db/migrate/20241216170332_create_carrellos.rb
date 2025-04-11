class CreateCarrellos < ActiveRecord::Migration[6.1]
  def change
    create_table :carrellos do |t|
      t.references :acquirente, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
