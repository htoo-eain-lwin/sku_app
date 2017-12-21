class PopulateWarehousesService
  def self.call
    Warehouse.find_or_create_by(name: "Warehouse SG",distribution_center_id: DistributionCenter.find_by(name: "Singapore").id)
    Warehouse.find_or_create_by(name: "Warehouse Thailand",distribution_center_id: DistributionCenter.find_by(name: "Thailand").id)
  end
end