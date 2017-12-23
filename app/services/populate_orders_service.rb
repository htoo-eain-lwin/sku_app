class PopulateOrdersService
  def self.call
    Order.destroy_all
    20.times.each do |i|
      Order.create(
        inventory_id: Inventory.pluck(:id).sample,
        total: rand(1..3),
        shipping_status: "pending",
        customer_id: Customer.pluck(:id).sample,
        sales_person_id: SalesPerson.pluck(:id).sample
      )
    end
  end
end