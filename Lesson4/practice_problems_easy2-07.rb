class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

p Cat.new('calico')
p Cat.new('tabby')
p Cat.new('black')
p Cat.cats_count

puts <<-QA

Q. Explain what the @@cats_count variable does and how it works. 
   What code would you need to write to test your theory?

A. It's a class variable that keeps a count of the total number of
   Cat objects that have been created.  The getter method self.cats_count
   allows you to access that number through the class Cat, like
   Cat.cats_count
   The above statements create 3 cats and print the cats_count.
   
QA
