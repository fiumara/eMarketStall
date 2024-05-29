class CreateVariantis < ActiveRecord::Migration[6.1]
  def change
    create_table :variantis do |t|
      t.references :prodotto, null: false, foreign_key: true 
      t.string :taglia   
      t.string :colore
      

      t.timestamps
    end
  end
end
