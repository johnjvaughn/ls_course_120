class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

puts <<-QA

Q. If we have a class AngryCat how do we create a new instance of this class?

A. AngryCat.new

QA

cat = AngryCat.new
cat.hiss
