require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe "factory" do
    it "should have a valid factory" do
      warehouse = FactoryBot.build :warehouse
      expect(warehouse.valid?).to eq(true)
    end
  end

  describe "association" do
    it "should belongs to distribution center" do
      distribution = FactoryBot.create :distribution_center
      warehouse = FactoryBot.create :warehouse, distribution_center_id: distribution.id
      expect(warehouse.distribution_center).to eq(distribution)
    end

    it "has many inventories" do
      warehouse = FactoryBot.create :warehouse
      2.times.each{|time| FactoryBot.create :inventory, warehouse_id: warehouse.id}
      expect(warehouse.inventories.count).to eq(2)
    end
  end

  describe "validation" do
    it "should have valid distribution_center" do
      warehouse = FactoryBot.build :warehouse,distribution_center_id: nil
      expect(warehouse.valid?).to eq(false)
    end

    it "should have name presence" do
      warehouse = FactoryBot.build :warehouse,name: nil
      expect(warehouse.valid?).to eq(false)
    end
  end


end
