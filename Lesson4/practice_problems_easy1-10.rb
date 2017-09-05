class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

puts <<-QA
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

Q. What would you need to call to create a new instance of this class?

A. Bag.new(<a color>, <a material>)

QA

