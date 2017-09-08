class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.size
  end
end

class Pet
  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{@animal} named #{@name}"
  end
end

class Shelter
  def initialize(pets)
    @owners = []
    @pets = pets
  end

  def adopt(owner, pet)
    if @pets.include?(pet)
      @owners << owner unless @owners.include?(owner)
      owner.add_pet(pet)
      @pets.delete(pet)
    else
      puts "Error in adopt method: "
      puts "The shelter does not currently have that pet: #{pet}."
    end
  end

  def print_adoptions
    @owners.each do |owner|
      puts "#{owner.name} has adopted:  #{owner.pets.join(', ')}"
    end
  end

  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    puts @pets.join("\n")
  end

  def num_unadopted_pets
    @pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')
fluffy       = Pet.new('cat', 'Fluffy')
chatterbox   = Pet.new('parakeet', 'Chatterbox')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new([butterscotch, pudding, darwin, kennedy, sweetie, molly, chester, asta, fluffy, chatterbox])
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

shelter.print_unadopted
puts "The Animal Shelter has #{shelter.num_unadopted_pets} unadopted pets."
