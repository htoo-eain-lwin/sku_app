class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :warehouse
  has_many :orders

  validates :product_id, presence: true
  validates :warehouse_id, presence: true
  validates :count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :from_singapore, -> { where(warehouse_id: DistributionCenter::Singapore.warehouses.pluck(:id))}
  scope :from_thailand, -> { where(warehouse_id: DistributionCenter::Thailand.warehouses.pluck(:id))}
end
