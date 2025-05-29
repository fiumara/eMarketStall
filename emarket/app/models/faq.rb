class Faq < ApplicationRecord
    validates :domanda, presence: { message: "non può essere vuota" }
    validates :risposta, presence: { message: "non può essere vuota" }
  end
  
