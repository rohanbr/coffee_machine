RSpec.describe CoffeeMachine do

  before do
    @coffee_machine = CoffeeMachine.new(4)
  end

  context "adding ingredients" do
    it "should add ingredients to the coffeemachine" do
      @coffee_machine.add_ingredient('water', 100)
      @coffee_machine.add_ingredient('tea powder', 100)
      expect(@coffee_machine.ingredients.size).to eq(2)
    end

    it "should create ingredients after adding ingredients to coffeemachine" do
      @coffee_machine.add_ingredient('water', 100)
      expect(@coffee_machine.ingredients.values[0].name).to eq('water')
      expect(@coffee_machine.ingredients.values[0].total_quantity).to eq(100)
    end
  end

  context "Beverage" do
    before do
      @coffee_machine = CoffeeMachine.new(4)
      @coffee_machine.add_ingredient('water', 100)
      @coffee_machine.add_ingredient('tea_powder', 100)
      @coffee_machine.add_ingredient('milk', 100)
      @coffee_machine.add_ingredient('sugar_syrup', 100)
    end

    context "creating beverage" do
      before do
        @be = Beverage.new('tea')
        @be.add_requirements('water', 30)
        @be.add_requirements('tea_powder', 50)
        @be.add_requirements('milk', 60)
        @be.add_requirements('sugar_syrup', 90)
      end

      it "should add requirments to the beverage" do
        expect(@be.beverage_requirements[0].name).to eq('water')
        expect(@be.beverage_requirements[0].required_quantity).to eq(30)
      end

      it "should return available ingredients" do
        expect(@be.ingredients(@coffee_machine, true).map(&:name)).to eq(["water", "tea_powder", "milk", "sugar_syrup"])
      end

      it "should reduce quantity after beverage creation" do
        @be.create(@coffee_machine)
        expect(@coffee_machine.ingredients['water'].available_quantity).to eq(70)
        expect(@coffee_machine.ingredients['tea_powder'].available_quantity).to eq(50)
        expect(@coffee_machine.ingredients['milk'].available_quantity).to eq(40)
        expect(@coffee_machine.ingredients['sugar_syrup'].available_quantity).to eq(10)
      end
    end

    context "printing output" do

      context "on create successfully" do
        before do
          @be = Beverage.new('tea')
          @be.add_requirements('water', 30)
          @be.add_requirements('tea_powder', 50)
          @be.add_requirements('milk', 60)
          @be.add_requirements('sugar_syrup', 90)
        end

        it "should return tea is prepared" do
          out = @be.generate_beverage(@coffee_machine)
          expect(out).to eq("tea is prepared")
        end
      end

      context "on not availability" do
        before do
          @be = Beverage.new('tea')
          @be.add_requirements('distilled_water', 30)
          @be.add_requirements('tea_powder', 50)
          @be.add_requirements('milk', 60)
          @be.add_requirements('sugar_syrup', 90)
        end

        it "should return tea cant be prepared because item distilled_water is not available" do
          out = @be.generate_beverage(@coffee_machine)
          expect(out).to eq("tea cannot be prepared because item distilled_water is not available")
        end
      end
    end
  end
end
