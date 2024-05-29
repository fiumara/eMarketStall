class CreateNegozios < ActiveRecord::Migration[6.1]
  def change
    create_table :negozios, id: :uuid do |t|
      t.string :nome_negozio
      t.string :email
      t.string :telefono
      t.references :acquirente, null: false, foreign_key: true 

      t.timestamps
    end
  end
end
