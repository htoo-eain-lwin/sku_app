class PopulateInventoryService
  def self.call
    Inventory.destroy_all
    30.times.each do |index|
      Inventory.create(product_id: Product.pluck(:id).sample, warehouse_id: Warehouse.pluck(:id).sample, count: rand(50..100))
    end
  end
end

