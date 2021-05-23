class Cart < ApplicationRecord
  belongs_to :user
  has_many :product_adapters, as: :purchasable


  before_save :set_subtotal

  def subtotal
    product_adapters.collect {|product_adapter| product_adapter.valid? ? (product_adapter.item_price*product_adapter.product_quantity) : 0}.sum
  end

  private
  def set_subtotal
    self[:subtotal] = subtotal
  end
end
