class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Dog
  def speak
    'meow'
  end

  def swim
    'can\'t swim!'
  end
  
  def fetch
    'won\'t fetch!'
  end
end

pixie = Cat.new
puts pixie.speak
puts pixie.swim
puts pixie.run
puts pixie.jump
puts pixie.fetch
