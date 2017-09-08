class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

puts <<-QA

Q. How can this class be fixed to be resistant to future problems?

A. Remove the public write access to instance var @database_handle.
It is unlikely this should ever be changed from outside the class,
so remove the setter method (and maybe the getter access as well).

QA
