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
end
