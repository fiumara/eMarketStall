class CarrelloItem < ApplicationRecord
  belongs_to :ordine, optional: true # 🔥 Un carrello_item può appartenere a un ordine
 
  belongs_to :carrello


  belongs_to :prodotto


  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
end
