class Amministratore < ApplicationRecord
    has_secure_password

    has_many :messaggi_inviati, as: :mittente, class_name: 'Messaggio'
    has_many :messaggi_ricevuti, as: :destinatario, class_name: 'Messaggio'

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    def nome_completo
        "#{nome} #{cognome}"
    end

    def self.designato
        find_by(email: 'giovanni.neri@example.com') || first
      end

    
end
