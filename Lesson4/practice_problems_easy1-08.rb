class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

puts <<-QA
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

Q. You can see in the make_one_year_older method we have used self. 
   What does self refer to here?

A. Here, self refers to the instance, or calling object.

QA

