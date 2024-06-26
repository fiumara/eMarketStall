class CreateFaqs < ActiveRecord::Migration[6.1]
  def change
    create_table :faqs, id: false do |t|
      t.integer :id, primary_key: true
      t.string :domanda
      t.string :risposta

      t.timestamps
    end
  end
end
