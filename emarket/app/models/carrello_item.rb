class CarrelloItem < ApplicationRecord
  belongs_to :carrello, optional: true 
  belongs_to :carrello
  belongs_to :prodotto
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  
end
