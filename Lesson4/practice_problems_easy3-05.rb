class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

puts <<-QA

Q. What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model

A. NoMethodError will result for these:
tv.manufacturer
Television.model

because manufacturer is a class method being called on an instance,
while model is an instance method called on a class

QA

tv = Television.new
begin
  tv.manufacturer
rescue NoMethodError
  puts "rescued NoMethodError caused by tv.manufacturer"
end
tv.model

Television.manufacturer
begin
  Television.model
rescue NoMethodError
  puts "rescued NoMethodError caused by Television.model"
end
