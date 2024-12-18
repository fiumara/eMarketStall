class Carrello < ApplicationRecord
  belongs_to :acquirente
  has_many :carrello_items, dependent: :destroy
  has_many :prodotti, through: :carrello_items
end
