class Transform
  def initialize(str)
    @str = str
  end

  def uppercase
    @str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase  # => ABC
puts Transform.lowercase('XYZ') # => xyz
