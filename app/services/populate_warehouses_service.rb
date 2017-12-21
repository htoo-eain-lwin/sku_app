class PopulateWarehousesService
  def self.call
    Warehouse.destroy_all
    Warehouse.create(id: 1, name: "Warehouse SG", distribution_center_id: 1)
    Warehouse.create(id: 2, name: "Warehouse Thailand", distribution_center_id: 2)
  end
end