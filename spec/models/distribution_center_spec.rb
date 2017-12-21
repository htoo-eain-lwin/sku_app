require 'rails_helper'

RSpec.describe DistributionCenter, type: :model do
  describe "factory" do
    it "should have a valid factory" do
      dist = FactoryBot.build :distribution_center
      expect(dist.valid?).to eq(true)
    end
  end

  describe "#validations" do
    it "name should presence" do
      dist = FactoryBot.build :distribution_center, name: nil
      expect(dist.valid?).to eq(false)
    end
  end

  describe "associations" do
    it "has many warehouses" do
      dist = FactoryBot.create :distribution_center
      2.times.each{|i| FactoryBot.create :warehouse,distribution_center_id: dist.id}
      expect(dist.warehouses.count).to eq(2)
    end
  end
end
