class ProductAdapter < ApplicationRecord
    belongs_to :product
    belongs_to :purchasable, polymorphic: true
end
