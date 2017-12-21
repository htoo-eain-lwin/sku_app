require 'rails_helper'

describe WarehousePolicy do

  subject { WarehousePolicy }

  let(:user) {
    user = FactoryBot.create(:user)
  }

  let(:warehouse) {
    warehouse = FactoryBot.create(:warehouse)
  }

  permissions :create?, :update?, :destroy? do
    it "allows admin on all actions" do
      user.add_role :admin
      expect(subject).to permit(user,warehouse)
    end
  end
end
