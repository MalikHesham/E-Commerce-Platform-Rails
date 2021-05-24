class Store < ApplicationRecord
  validates :name, :summary, presence: true
  belongs_to :user
  has_many :products
end
