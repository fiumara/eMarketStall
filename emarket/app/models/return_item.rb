class ReturnItem < ApplicationRecord
  belongs_to :return_request
  belongs_to :prodotto

  validates :quantita, numericality: { greater_than: 0 }
end
