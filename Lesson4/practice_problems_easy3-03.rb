class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

puts <<-QA

Q. Given the class AngryCat, how do we create two different instances 
   of this class, both with separate names and ages?

A. cat1 = AngryCat.new(4, "Billy")
   cat2 = AngryCat.new(2, "Boo")

QA

cat1 = AngryCat.new(4, "Billy")
cat2 = AngryCat.new(2, "Boo")
p cat1
p cat2

