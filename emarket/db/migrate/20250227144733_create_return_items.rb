class CreateReturnItems < ActiveRecord::Migration[6.1]
  def change
    create_table :return_items do |t|
      t.references :return_request, null: false, foreign_key: true
      t.references :prodotto, null: false, foreign_key: true
      t.references :ordine_item, null: false, foreign_key: true
      t.integer :quantita, null: false, default: 1

      t.timestamps
    end
  end
end

