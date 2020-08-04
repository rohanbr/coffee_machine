class BeverageRequirement

  attr_accessor :required_quantity, :name

  def initialize(name, required_quantity)
    @name = name
    @required_quantity = required_quantity
  end

end
