class Acquirente < ApplicationRecord
    has_secure_password

    has_one :negozio, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
