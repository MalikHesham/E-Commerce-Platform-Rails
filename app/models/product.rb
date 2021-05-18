class Product < ApplicationRecord
  validates :title, :description, :price, :in_stock, presence: true
  belongs_to :brand
  belongs_to :category
  has_many_attached :images
end
