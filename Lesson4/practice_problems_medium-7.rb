class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

puts <<-QA

Q. How could you change the method name so that the method name is more clear and less repetitive?

A. Just make it self.information, so it can be called as
Light.information 
instead of
Light.light_information

QA
