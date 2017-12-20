class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse
  has_many :orders

  validates :product_id, presence: true
  validates :warehouse_id, presence: true
  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
