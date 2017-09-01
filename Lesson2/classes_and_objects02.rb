class Person
  attr_reader :name, :first_name, :last_name

  def initialize(name)
    @name = name
    @first_name = name
    @last_name = ''
  end

  def last_name=(last_name)
    @last_name = last_name
    @name = "#{first_name} #{last_name}"
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'