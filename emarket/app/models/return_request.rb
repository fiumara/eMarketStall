class ReturnRequest < ApplicationRecord
  belongs_to :ordine
  belongs_to :acquirente, class_name: "Acquirente" 
  has_many :return_items, dependent: :destroy
  accepts_nested_attributes_for :return_items , allow_destroy: true, reject_if: proc { |attributes| attributes['quantita'].to_i <= 0 }

  enum stato: { in_attesa: 0, approvato: 1, rifiutato: 2 }

  validates :motivo, presence: true
end
