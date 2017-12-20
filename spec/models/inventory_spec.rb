require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe "#valid factory" do
    it "should have a valid factory" do
      inventory = FactoryBot.build :inventory
      expect(inventory.valid?).to eq(true)
    end
  end

  describe "association" do
    it "belongs to product" do
      pro = FactoryBot.create :product
      inventory = FactoryBot.create :inventory, product_id: pro.id
      expect(inventory.product).to eq(pro)
    end
    it "belongs to warehouse" do
      warehouse = FactoryBot.create :warehouse
      inventory = FactoryBot.create :inventory, warehouse_id: warehouse.id
      expect(inventory.warehouse).to eq(warehouse)
    end
  end

  describe "validations" do
    it "should have product_id presence" do
      inventory = FactoryBot.build :inventory, product_id: ""
      expect(inventory.valid?).to eq(false)
    end

    it "should have warehouse_id presence" do
      inventory = FactoryBot.build :inventory, warehouse_id: nil
      expect(inventory.valid?).to eq(false)
    end

    it "should have count value greater than equal 0" do
      inventory = FactoryBot.build :inventory, count: -1
      expect(inventory.valid?).to eq(false)
    end
  end
end
