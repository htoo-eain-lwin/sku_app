class Order < ApplicationRecord
  belongs_to :inventory
  belongs_to :customer, class_name: "User"
  belongs_to :sales_person, class_name: "User"

  validates :inventory_id, presence: true
  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :shipping_status, presence: true, inclusion: { in: OrderOptions.status_collection}
  scope :reserved, -> {where(shipping_status: "reserved")}
  scope :shipped, -> {where(shipping_status: "shipped")}
  scope :cancelled, -> {where(shipping_status: "cancelled")}

  after_update :adjustment_inventory, if: :saved_change_to_shipping_status?

  def adjustment_inventory
    if shipping_status == "cancelled"
      AdjustmentInventory.new.refill(self)
    else
      AdjustmentInventory.new.reduce(self)
    end
  end
end