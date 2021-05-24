class Product < ApplicationRecord
  
  include Filterable
  
  validates :title, :description, :price, :in_stock, presence: true


  scope :filter_by_category, -> (category) { joins(:category).where(:categories => { :name => category.downcase }) }
  scope :filter_by_brand, -> (brand) { joins(:brand).where(:brands => { :name => brand.downcase }) }
  scope :filter_by_price_lte, -> (price) { where("price <= ?", price) }
  scope :filter_by_price_gte, -> (price) { where("price >= ?", price) }
  # scope :filter_by_seller, -> (seller) { where(:id => seller.to_i) }

  scope :search_by_title_or_description, -> (q) {where("title like ? or description like ?", "%#{q}%", "%#{q}%")}


  belongs_to :brand
  belongs_to :category
  belongs_to :store
  has_many_attached :images
end
