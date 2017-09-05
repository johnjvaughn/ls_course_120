class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 3
  end

  def make_one_year_older
    current_age = age
    @age = current_age + 1
  end
end

puts <<-QA

Q. In the make_one_year_older method we have used self. 
   What is another way we could write this method so we don't have to use the self prefix?

A. Replace self.age with @age instance variable

QA

cat = Cat.new('calico')
puts "New #{cat.type} cat is now #{cat.age} years old."

cat.make_one_year_older
puts "A year later, #{cat.type} cat is now #{cat.age} years old."