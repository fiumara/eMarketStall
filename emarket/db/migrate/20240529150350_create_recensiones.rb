class CreateRecensiones < ActiveRecord::Migration[6.1]
  def change
    create_table :recensiones, id: :uuid do |t|
    #  t.references :prodotto, null: false, foreign_key: true 
     #  t.string :   
     #t.string :colore
    #  t.timestamps
    end
  end
end
