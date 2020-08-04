class Ingredient

  attr_accessor :name, :total_quantity, :available_quantity

  def initialize(name, total_quantity)
    @name = name
    @total_quantity = total_quantity
    @available_quantity = total_quantity
  end

  def refill
    @available_quantity = total_quantity
  end

  def remove(quantity)
    @available_quantity -= quantity
  end

  def has?(quantity)
    @available_quantity >= quantity
  end

end
