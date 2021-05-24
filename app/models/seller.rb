class Seller < ApplicationRecord
    belongs_to :user
    has_many :store
    has_many :product
    has_many :order
end
