class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

puts <<-QA

Q. What could you add to this class to simplify it and remove two methods
   from the class definition while still maintaining the same functionality?

A. Add an attr_accessor for instance variable @type.
attr_accessor :type

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

QA
