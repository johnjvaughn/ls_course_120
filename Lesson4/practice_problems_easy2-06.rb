puts <<-QA

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

Q. Which one of these is a class method (if any) and how do you know? 
   How would you call a class method?

A. self.manufacturer is the class method because of the self. prefix.
   You call a class method by appending to a class name or reference (omitting
   the "self." when calling it), such as:

   Television.manufacturer
   or
   tv = Television.new
   tv.class.manufacturer

QA
