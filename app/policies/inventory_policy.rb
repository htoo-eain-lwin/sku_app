class InventoryPolicy

  attr_reader :user, :inventory

  def initialize(user, inventory)
    @user = user
    @inventory = inventory
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
