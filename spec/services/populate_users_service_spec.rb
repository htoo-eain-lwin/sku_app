require "rails_helper"

describe PopulateUsersService do
  it 'exists as a class' do
    expect { described_class.call}.not_to raise_error
  end

  it 'can be called to create admin' do
    result = described_class.call
    expect(User.first.email).to eq(Figaro.env.sku_admin_email)
    expect(User.first.has_role?(:admin)).to eq(true)
  end
end