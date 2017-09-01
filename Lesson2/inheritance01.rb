class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    'can\'t swim!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
georgia = Bulldog.new
puts georgia.speak           # => "bark!"
puts georgia.swim           # => "swimming!"
