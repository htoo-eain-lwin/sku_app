class PopulateDistributionCenterService
  def self.call
    DistributionCenter.destroy_all
    locations = ["Singapore","Thailand"]
    locations.each_with_index{|location, index| DistributionCenter.create(id: index+1, name: location)}
  end
end