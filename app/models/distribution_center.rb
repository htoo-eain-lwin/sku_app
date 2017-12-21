class DistributionCenter < ApplicationRecord
  validates :name, presence: true
  has_many :warehouses
  class Singapore
    def self.warehouses
      DistributionCenter.find_by(name: "Singapore").warehouses
    end
  end
  class Thailand
    def self.warehouses
      DistributionCenter.find_by(name: "Thailand").warehouses
    end
  end
end
