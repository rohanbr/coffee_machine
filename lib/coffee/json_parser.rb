class JsonParser

  attr_accessor :json_data

  def initialize(json_data)
    @json_data = json_data
  end

  def perform
    create_coffe_machine
    add_ingredients
    create_beverages
    @coffee_machine.generate_beverages(@all_beverages)
  end

  private

  def create_coffe_machine
    @coffee_machine = CoffeeMachine.new(outlets)
  end

  def add_ingredients
    @ingredients = []
    all_items.each do |name, quantity|
      @coffee_machine.add_ingredient(name, quantity)
    end
  end

  def create_beverages
    @all_beverages = []
    beverages.each do |name, requirements|
      beverage = Beverage.new(name)
      requirements.each do |ingredient_name, quantity|
        beverage.add_requirements(ingredient_name, quantity)
      end
      @all_beverages << beverage
    end
  end

  def outlets
    @outlets ||= json_data[:machine][:outlets][:count_n]
  end

  def all_items
    @all_items ||= json_data[:machine][:total_items_quantity]
  end

  def beverages
    @beverages ||= json_data[:machine][:beverages]
  end
end
