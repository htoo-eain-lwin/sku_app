require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid factory" do
    it "should have a valid factory" do
      order = FactoryBot.build :order
      expect(order.valid?).to eq(true)
    end
  end

  describe "association" do
    it "belongs to inventory" do
      inventory = FactoryBot.create :inventory
      order = FactoryBot.create :order, inventory_id: inventory.id
      expect(order.inventory).to eq(inventory)
    end
  end

  describe "validations" do
    it "should have inventory_id presence" do
      order = FactoryBot.build :order, inventory_id: nil
      expect(order.valid?).to eq(false)
    end

    it "should have toal presence" do
      order = FactoryBot.build :order, total: nil
      expect(order.valid?).to eq(false)
    end

    it "should have total value greater 0" do
      order = FactoryBot.build :order, total: 0
      expect(order.valid?).to eq(false)
    end

    it "should have shipping_status include in collection" do
      order = FactoryBot.build :order, shipping_status: "foo"
      expect(order.valid?).to eq(false)
    end
  end
end
