class Acquirente < ApplicationRecord
    has_secure_password

    has_many :recensioni, dependent: :destroy

    has_one :negozio, dependent: :destroy

    has_many :wishlist_items, dependent: :destroy
    
    has_many :wishlist, through: :wishlist_items, source: :prodotto

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
