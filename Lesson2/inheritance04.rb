class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

puts <<-QA

Q. What is the method lookup path and how is it important?

A. It's the order of places where Ruby looks for a method
definition within the class hierarchy. First within the
class itself, then within included modules, and then the
class's parent class, and so on, moving up to further ancestors
if necessary.
  
QA