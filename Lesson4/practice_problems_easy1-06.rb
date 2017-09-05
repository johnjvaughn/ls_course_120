class Cube
  def initialize(volume)
    @volume = volume
  end
end

puts <<-QA

Q. What could we add to the class below to access the instance variable @volume?

A. a getter method that returns @volume, or an attribute reader, 
   attr_reader :volume

QA

