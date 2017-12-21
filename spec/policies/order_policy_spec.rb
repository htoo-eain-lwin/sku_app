require 'rails_helper'

describe OrderPolicy do

  subject { OrderPolicy }

  let(:user) {
    user = FactoryBot.create(:user)
  }

  let(:order) {
    order = FactoryBot.create(:order)
  }

  permissions :create?, :update?, :destroy? do
    it "allows admin on all actions" do
      user.add_role :admin
      expect(subject).to permit(user,order)
    end
  end

  permissions :create?, :update? do
    it "allows sales_person on all actions" do
      user.add_role :sales_person
      expect(subject).to permit(user,order)
    end
  end

  permissions :destroy? do
    it "doesnt allow sales_person on destroy actions" do
      user.add_role :sales_person
      expect(subject).not_to permit(user,order)
    end
  end
end
