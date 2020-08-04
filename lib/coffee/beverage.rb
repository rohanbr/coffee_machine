class Beverage

  attr_accessor :name, :beverage_requirements

  def initialize(name)
    @name = name
    @beverage_requirements = []
  end

  def add_requirements(ingredient_name, quantity)
    beverage_requirement = BeverageRequirement.new(ingredient_name, quantity)
    @beverage_requirements << beverage_requirement
  end

  def generate_beverage(coffee_machine)
    insuff_ingredients = insuffiecent_ingridients(coffee_machine)
    unavailable_ingredients = ingredients(coffee_machine, false)
    if insuff_ingredients.empty? && unavailable_ingredients.empty?
      create(coffee_machine)
      puts("#{name} is prepared")
      return "#{name} is prepared"
    else
      puts("#{name} cannot be prepared because item #{unavailable_ingredients[0].name} is not available") if !unavailable_ingredients.empty?
      return "#{name} cannot be prepared because item #{unavailable_ingredients[0].name} is not available" if !unavailable_ingredients.empty?
      puts("#{name} cannot be prepared because item #{insuff_ingredients[0].name} is not sufficient") if !insuff_ingredients.empty?
      return "#{name} cannot be prepared because item #{insuff_ingredients[0].name} is not sufficient" if !insuff_ingredients.empty?
    end
  end

  def ingredients(coffee_machine, scope)
    @beverage_requirements.select do |beverage_requirement|
      coffee_machine.ingredients.keys.include?(beverage_requirement.name) == scope
    end
  end

  def insuffiecent_ingridients(coffee_machine)
    ingredients(coffee_machine, true).select do |beverage_requirement|
      ingridient = coffee_machine.ingredients[beverage_requirement.name]
      !ingridient.has?(beverage_requirement.required_quantity)
    end
  end

  def create(coffee_machine)
    @beverage_requirements.each do |beverage_requirement|
      ingridient = coffee_machine.ingredients[beverage_requirement.name]
      ingridient.remove(beverage_requirement.required_quantity)
    end
  end
end
