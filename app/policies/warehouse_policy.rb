class WarehousePolicy

  attr_reader :user, :warehouse

  def initialize(user, warehouse)
    @user = user
    @warehouse = warehouse
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
