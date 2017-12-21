class PopulateDistributionCenterService
  def self.call
    locations = ["Singapore","Thailand"]
    locations.each{|location| DistributionCenter.find_or_create_by(name: location)}
  end
end