class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

puts <<-QA

Q. Which of these two classes has an instance variable and how do you know?

A. class Pizza has an instance variable -- I know because it starts with @

QA

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

p hot_pizza.instance_variables
p orange.instance_variables
