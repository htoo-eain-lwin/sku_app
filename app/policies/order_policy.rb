class OrderPolicy

  attr_reader :user, :order

  def initialize(user, order)
    @user = user
    @order = order
  end

  def create?
    user.has_role?(:admin) || user.has_role?(:sales_person)
  end

  def update?
    create?
  end

  def destroy?
    user.has_role?(:admin)
  end
end
