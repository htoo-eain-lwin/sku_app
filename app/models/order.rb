class Order < ApplicationRecord
  belongs_to :inventory

  validates :inventory_id, presence: true
  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :shipping_status, presence: true, inclusion: { in: OrderOptions.status_collection}


end
