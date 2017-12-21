require 'rails_helper'

describe ProductPolicy do

  subject { ProductPolicy }

  let(:user) {
    user = FactoryBot.create(:user)
  }

  let(:product) {
    product = FactoryBot.create(:product)
  }

  permissions :create?, :update?, :destroy? do
    it "allows admin on all actions" do
      user.add_role :admin
      expect(subject).to permit(user,product)
    end
  end
end
