class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

puts <<-QA

Q. What happens in each of the following cases:

1.
hello = Hello.new
hello.hi

A. "Hello" is printed

2.
hello = Hello.new
hello.bye

A. NoMethodError

3.
hello = Hello.new
hello.greet

A. ArgumentError (1 argument expected by greet)

4.
hello = Hello.new
hello.greet("Goodbye")

A. "Goodbye" is printed

5.
Hello.hi

A. NoMethodError (hi is an instance method, not a class method)

QA

hello = Hello.new
hello.hi

begin
  hello = Hello.new
  hello.bye
rescue NoMethodError
  puts "rescue of hello.bye NoMethodError"
end

begin
  hello = Hello.new
  hello.greet
rescue ArgumentError
  puts "rescue of hello.greet ArgumentError"
end

hello = Hello.new
hello.greet("Goodbye")

begin
  Hello.hi
rescue NoMethodError
  puts "rescue of Hello.hi NoMethodError"
end

