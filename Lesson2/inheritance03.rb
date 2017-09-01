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

puts <<-DIAGRAM
              Pet
          (run, jump)
        /             \\
     Dog               Cat
(speak, fetch, swim)  (speak)
    /
 Bulldog
  (swim)
DIAGRAM