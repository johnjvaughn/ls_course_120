module Refuelable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end


class WheeledVehicle
  include Refuelable
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Seacraft
  include Refuelable

  attr_accessor :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end

  def range
    super + 10
  end
end

class Catamaran < Seacraft
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

car = Auto.new
puts "New car's range is: #{car.range}"
boat = Motorboat.new(10, 10)
puts "New boat (10 km/l, 10 l tank) has a range of #{boat.range}"