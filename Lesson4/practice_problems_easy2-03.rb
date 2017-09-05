module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts <<-QA

Q. How do you find where Ruby will look for a method when that method is called? 

A. It will look locally in the class, then in included modules (last first),
   then in the superclass, modules within the superclass, and on up the inheritance chain.

Q. How can you find an object's ancestors?

A. The ancestors method:  <class>.ancestors or <object>.class.ancestors

Q. What is the lookup chain for Orange and HotSauce?

A. 1. local, 2. in module Taste, 3. Object, 4. Kernel, 5. BasicObject

QA
