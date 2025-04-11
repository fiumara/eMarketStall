class CreateReturnRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :return_requests do |t|
      t.references :ordine, null: false, foreign_key: true
      t.references :acquirente, null: false, foreign_key: { on_delete: :nullify }
      t.string :motivo
      t.integer :stato, default: 0  

      t.timestamps
    end
  end
end

