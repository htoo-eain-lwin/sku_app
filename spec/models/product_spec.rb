require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "factory" do
    it "has valid factory" do
      prod = FactoryBot.build :product
      expect(prod.valid?).to eq(true)
    end
  end

  describe "#validations" do
    it "should have name presence" do
      prod = FactoryBot.build :product, name: ""
      expect(prod.valid?).to eq(false)
    end

    it "should have price presence" do
      prod = FactoryBot.build :product, price: nil
      expect(prod.valid?).to eq(false)
    end

    it "should have price value greater than 0" do
      prod = FactoryBot.build :product, price: 0
      expect(prod.valid?).to eq(false)
    end
  end
end
