require 'coffee/beverage'
require 'pry'
class CoffeeMachine

  attr_accessor :ingredients

  def initialize(outlets)
    @outlets = outlets
    @ingredients = []
    @mutex = Mutex.new
    @ingredients = {}
  end

  def add_ingredient(name, total_quantity)
    @ingredients[name] = Ingredient.new(name, total_quantity)
  end

  def generate_beverages(beverages)
    beverages.each do |beverage|
      Thread.new do
        @mutex.synchronize do
          beverage.generate_beverage(coffee_machine)
        end
      end
    end
  end
end
