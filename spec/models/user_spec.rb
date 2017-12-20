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
