class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

puts <<-QA

Q. If we call Hello.hi we get an error message. How would you fix this?

A. Make both the hi method and the greet method into class methods by
   prepending "self." to their declrations.  Or simply instantiate the class
   first and call the hi method on the instance.

QA

begin
  Hello.hi
rescue NoMethodError
  puts "rescue of Hello.hi NoMethodError"
end

