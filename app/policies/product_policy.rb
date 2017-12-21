class ProductPolicy

  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def create?
    user.has_role?(:admin)
  end

  def update?
    create?
  end

  def destroy?
    update?
  end
end
