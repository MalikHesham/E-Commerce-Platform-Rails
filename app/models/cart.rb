class Cart < ApplicationRecord
  belongs_to :user
  has_many :product_adapters, as: :purchasable


  before_save :set_total


  def total
    product_adapters.collect {|product_adapter| product_adapter.valid? ? (product_adapter.item_price*product_adapter.product_quantity) : 0}.sum
  end

  private
  def set_total
    self[:total] = total
  end
end
