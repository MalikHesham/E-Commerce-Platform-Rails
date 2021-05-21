class Order < ApplicationRecord
  enum status: %i[pending confirmed delivered]
  belongs_to :user
  has_many :product_adapter, as: :purchasable
end
