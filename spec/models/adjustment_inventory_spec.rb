require 'rails_helper'

RSpec.describe AdjustmentInventory, type: :model do
  let(:inventory) {FactoryBot.create :inventory, count: 10}

  describe "#initialize" do
    it "should initialize order and inventory" do
      order = FactoryBot.create :order, inventory_id: inventory.id
      adjust = described_class.new(order)
      expect(adjust.order).to eq(order)
      expect(adjust.inventory).to eq(inventory)
    end
  end

  describe "#refill" do
    it "add inventory count" do
      order = FactoryBot.create :order, inventory_id: inventory.id,total: 5
      adjust = described_class.new(order)
      adjust.refill
      expect(adjust.inventory.count).to eq(15)
    end
  end

  describe "#reduce" do
    it "substract inventory count" do
      order = FactoryBot.create :order, inventory_id: inventory.id,total: 5
      adjust = described_class.new(order)
      adjust.reduce
      expect(adjust.inventory.count).to eq(5)
    end
    it "raise error if substraction less than zero" do
      order = FactoryBot.create :order, inventory_id: inventory.id,total: 15
      adjust = described_class.new(order)
      expect{ adjust.reduce}.to raise_error(AdjustmentInventory::AdjustmentCannotBeLessThanZero)
    end
  end
end

