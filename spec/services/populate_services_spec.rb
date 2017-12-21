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

describe PopulateProductService do
  it 'exists as a class' do
    expect { described_class.call}.not_to raise_error
  end

  it 'can be called to create products' do
    described_class.call
    expect(Product.count).to eq(50)
  end
end

describe PopulateDistributionCenterService do
  it 'exists as a class' do
    expect { described_class.call}.not_to raise_error
  end

  it 'can be called to create distribution center' do
    described_class.call
    expect(DistributionCenter.count).to eq(2)
  end
end

describe PopulateWarehousesService do
  it 'exists as a class' do
    expect { described_class.call}.not_to raise_error
  end
end

describe PopulateInventoryService do
  it 'exists as a class' do
    expect { described_class.call}.not_to raise_error
  end
end

describe PopulateOrdersService do
  it 'exists as a class' do
    expect { described_class.call}.not_to raise_error
  end
end