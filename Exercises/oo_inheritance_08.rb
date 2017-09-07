class Animal
end

class Cat < Animal
end

class Bird < Animal
end

puts "Lookup path is: Cat, Animal, Object, Kernel, BasicObject (not found)"

cat1 = Cat.new
cat1.color
