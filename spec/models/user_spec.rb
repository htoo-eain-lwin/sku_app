require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory" do
    it "has valid factory" do
      user = FactoryBot.build :user
      expect(user.valid?).to eq(true)
    end
  end

  describe "#callbacks" do
    it "assigns default role" do
      user = FactoryBot.create :user
      expect(user.has_role?(:user)).to eq(true)
    end
  end
end

RSpec.describe Customer, type: :model do
  describe "factory" do
    it "has valid factory" do
      customer = FactoryBot.build :customer
      expect(customer.valid?).to eq(true)
    end
  end

  describe "has role customer" do
    it "assigns default role" do
      user = FactoryBot.create :customer
      expect(user.has_role?(:customer)).to eq(true)
    end
  end
end

RSpec.describe SalesPerson, type: :model do
  describe "factory" do
    it "has valid factory" do
      sales = FactoryBot.build :sales_person
      expect(sales.valid?).to eq(true)
    end
  end

  describe "has role sales" do
    it "assigns default role" do
      user = FactoryBot.create :sales_person
      expect(user.has_role?(:sales)).to eq(true)
    end
  end
end
