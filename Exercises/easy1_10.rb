class Vehicle
  WHEELS = 0
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    self.class::WHEELS
  end
end

class Car < Vehicle
  WHEELS = 4
  def initialize(make, model)
    super
  end
end

class Motorcycle < Vehicle
  WHEELS = 2
  def initialize(make, model)
    super
  end
end

class Truck < Vehicle
  WHEELS = 6
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end

truck = Truck.new('Ford', '150', '400')
puts truck.wheels