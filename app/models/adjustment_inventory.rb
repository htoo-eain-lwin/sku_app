class AdjustmentInventory
  AdjustmentCannotBeLessThanZero = Class.new(StandardError)

  attr_accessor :order, :inventory

  def initialize(order)
    @order = order
    @inventory = order.inventory
  end

  def refill
    @inventory.update(count: @inventory.count+@order.total)
  end

  def reduce
    if @inventory.count - @order.total < 0
      raise AdjustmentCannotBeLessThanZero
    else
      @inventory.update(count: @inventory.count - @order.total)
    end
  end
end